import Foundation

protocol RequesterContract: AnyObject {
    func request(urlRequest: URLRequest, completion: @escaping (Result<Data, RequesterError>) -> Void)
}

final class Requester: RequesterContract {
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request(urlRequest: URLRequest, completion: @escaping (Result<Data, RequesterError>) -> Void)  {
        session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.requestError(localizedDescription: error?.localizedDescription ?? "")))
                return
            }
            guard let data = data else {
                completion(.failure(.unknownError))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
