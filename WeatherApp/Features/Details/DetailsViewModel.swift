import Combine
import Foundation
import SwiftUI

protocol DetailsViewModelContract: ObservableObject {
    var iconData: Data? { get set }
    var consolidatedWeather: ConsolidatedWeather? { get set }
    var title: String? { get set }
}

final class DetailsViewModel: DetailsViewModelContract {
    @Published var iconData: Data?
    @Published var consolidatedWeather: ConsolidatedWeather?
    @Published var title: String?
    let apiController: APIControllerContract
    
    init(locationWeather: LocationWeather?, apiController: APIControllerContract = APIController()) {
        self.consolidatedWeather = locationWeather?.consolidatedWeather.first
        self.title = locationWeather?.title
        self.apiController = apiController
        getIconData()
    }
    
    private func getIconData() {
        guard let abbreviation = consolidatedWeather?.weatherState?.abbreviation else { return }
        apiController.fetch(endpoint: .getIcon(abb: abbreviation)) { [weak self] (result: Result<Data, RequesterError>) in
            switch result {
            case .success(let iconData):
                DispatchQueue.main.async {
                    self?.iconData = iconData
                }
            case .failure(_):
                print()
            }
        }
    }
}
