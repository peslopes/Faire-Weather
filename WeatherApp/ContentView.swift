import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SearchViewFactory.make()
                .navigationTitle("Faire Weather")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
