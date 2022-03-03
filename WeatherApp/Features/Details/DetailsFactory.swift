import Foundation
import SwiftUI

final class DetailsFactory {
    @ViewBuilder
    static func make(locationWeather: LocationWeather?) -> some View {
        let viewModel = DetailsViewModel(locationWeather: locationWeather)
        DetailsView(viewModel: viewModel)
    }
}
