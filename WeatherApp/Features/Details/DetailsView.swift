import SwiftUI

struct DetailsView<ViewModel: DetailsViewModelContract>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title ?? "")
                .font(.title)
                .bold()
            HStack {
                Spacer()
                if let data = viewModel.iconData {
                    Image(uiImage: UIImage(data: data) ?? UIImage())
                } else {
                    ProgressView()
                }
                Text("\(String(Int(viewModel.consolidatedWeather?.theTemp ?? 0)))º")
                    .font(.largeTitle)
                Spacer()
            }
            HStack {
                Spacer()
                Text(viewModel.consolidatedWeather?.weatherStateName ?? "")
                    .font(.caption)
                Spacer()
            }
            HStack {
                Spacer()
                Text("L: \(String(Int(viewModel.consolidatedWeather?.minTemp ?? 0)))º")
                    .font(.title2)
                Text("H: \(String(Int(viewModel.consolidatedWeather?.maxTemp ?? 0)))º")
                    .font(.title2)
                Spacer()
            }
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsViewModel(locationWeather: LocationWeather(consolidatedWeather: [ConsolidatedWeather(minTemp: 1, maxTemp: 2, theTemp: 0, weatherStateName: "Heavy Rain")], title: "Toronto")))
    }
}
