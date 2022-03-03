import Foundation
import Combine

protocol SearchViewModelContract: ObservableObject {
    var shouldNavigate: Bool { get set }
    var locationWeather: LocationWeather? { get set }
    var isLoading: Bool { get set }
    func search(query: String)
}

final class SearchViewModel: SearchViewModelContract {
    var apiController: APIControllerContract
    @Published var locationWeather: LocationWeather? = nil
    @Published var isLoading = false
    @Published var shouldNavigate = false
    
    init(apiController: APIControllerContract = APIController()) {
        self.apiController = apiController
    }
    
    func search(query: String) {
        var endpoint: APIEndpoint?
        
        if let coordinates = query.convertToCoordinate() {
            endpoint = .searchByLattLong(latt: coordinates.latt, long: coordinates.long)
        } else if let woeid = Int(query) {
            endpoint = .searchByWoeid(woeid: woeid)
        } else {
            endpoint = .searchByQuery(query: query)
        }
        
        guard let endpoint = endpoint else { return }
        
        isLoading = true
        apiController.fetch(endpoint: endpoint) { [weak self] (result: Result<LocationWeather, RequesterError>) in
            switch result {
            case .success(let locationWeather):
                DispatchQueue.main.async {
                    self?.locationWeather = locationWeather
                    self?.shouldNavigate = true
                }
            case .failure(_):
                print()
            }
            DispatchQueue.main.async {
                self?.isLoading = false
            }
        }
    }
}
