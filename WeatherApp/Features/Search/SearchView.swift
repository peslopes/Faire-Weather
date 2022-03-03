import SwiftUI

struct SearchView<ViewModel: SearchViewModelContract>: View {
    @ObservedObject var viewModel: ViewModel
    @State var searchString = ""
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
        } else {
            searchScreenView
        }
    }
    
    var searchScreenView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("You can search by a name of a location, by coordinates or by woeid")
                .font(.title3)
            Text("Examples:")
                .font(.caption)
            Text("Try search \"Toronto\"")
                .font(.caption)
            Text("Try search \"43.633225, -79.383286\"")
                .font(.caption)
            Text("Try search \"4118\"")
                .font(.caption)
            TextField("Search", text: $searchString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack {
                Spacer()
                NavigationLink(destination: DetailsFactory.make(locationWeather: viewModel.locationWeather), isActive: $viewModel.shouldNavigate) { EmptyView() }
                Button("I'm feeling lucky", action: {
                    self.viewModel.search(query: searchString)
                })
                Spacer()
            }
            .padding(.top)
            Spacer()
        }
        .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
