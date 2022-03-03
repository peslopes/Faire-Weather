import Foundation
import SwiftUI

final class SearchViewFactory {
    @ViewBuilder
    static func make() -> some View {
        let viewModel = SearchViewModel()
        SearchView(viewModel: viewModel)
    }
}
