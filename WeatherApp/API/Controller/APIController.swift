import Foundation

protocol APIControllerContract: AnyObject {
    func fetch(endpoint: APIEndpoint, completion: @escaping (Result<Data, RequesterError>) -> Void )
    func fetch(endpoint: APIEndpoint, completion: @escaping (Result<LocationWeather, RequesterError>) -> Void)
}

final class APIController: APIControllerContract {
    
    let baseURL = "https://www.metaweather.com"
    let requester: RequesterContract
    let decoder: DecoderContract
    
    init(requester: RequesterContract = Requester(),
         decoder: DecoderContract = Decoder()) {
        self.requester = requester
        self.decoder = decoder
    }
    
    func fetch(endpoint: APIEndpoint, completion: @escaping (Result<Data, RequesterError>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint.url)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        requester.request(urlRequest: urlRequest, completion: completion)
    }
    
    func fetch(endpoint: APIEndpoint, completion: @escaping (Result<LocationWeather, RequesterError>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint.url)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        let dispatchGroup = DispatchGroup()
        var listRequestError: RequesterError?
        
        if endpoint.shouldReturnList {
            dispatchGroup.enter()
            fetch(urlRequest: urlRequest) { [weak self] (result: (Result<[SearchedLocationWeather], RequesterError>)) in
                switch result {
                    
                case .success(let searchedList):
                    if let searchedLocationWeather = searchedList.first {
                        
                        guard let self = self else {
                            listRequestError = .unknownError
                            return
                        }
                        
                        guard let url = URL(string: "\(self.baseURL)\(APIEndpoint.searchByWoeid(woeid: searchedLocationWeather.woeid).url)") else {
                            listRequestError = .invalidURL
                            return
                        }
                        urlRequest = URLRequest(url: url)
                    }
                case .failure(let error):
                    listRequestError = error
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global(qos: .background)) { [weak self] in
            guard listRequestError == nil else {
                completion(.failure(listRequestError ?? .unknownError))
                return
            }
            self?.fetch(urlRequest: urlRequest, completion: completion)
        }
    }
    
    private func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, RequesterError>) -> Void) {
        requester.request(urlRequest: urlRequest) { [weak self] result in
            switch result {
            case .success(let data):
                guard let self = self else {
                    completion(.failure(.unknownError))
                    return
                }
                do {
                    let object: T = try self.decoder.decode(data: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(.parseError(localizedDescription: error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
