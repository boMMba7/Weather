import SwiftUI
import Combine


struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @Binding var showing: Bool
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Search for a city", text: $viewModel.searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                List(viewModel.searchResults) { city in
                    VStack(alignment: .leading) {
                        Text(city.name ?? "")
                            .font(.title)
                            .foregroundColor(.primary)

                        HStack {
                            Text(city.country?.name ?? "")
                                .font(.subheadline)
                            Text(city.country?.emoji ?? "")
                                .font(.subheadline)
                        }
                        .foregroundColor(.secondary)
                    }
                    .onTapGesture {
                        viewModel.haveSelected(city: city)
                        showing = false
                    }
                    .listRowInsets(EdgeInsets()) // Optional: Remove row insets to avoid indentation
                }
            }
        }

    }
}

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [JsonCity] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let debounceInterval = 0.5 // Set the interval in seconds for debounce
    
    init() {
        $searchText
            .debounce(for: .seconds(debounceInterval), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] searchTerm in
                self?.performAPISearch(searchTerm: searchTerm)
            })
            .store(in: &cancellables)
    }
    
    func haveSelected(city: JsonCity){
        CoreDataManager.shared.cleanAndAddCityToUser(cityJsn: city)
    }
    
    private func performAPISearch(searchTerm: String) {
        if searchTerm == "" {
            return
        }
        
        CountriesAPI.shared.searchCountryes(keyword: searchTerm,completion: { [weak self] (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let res):
                    self?.searchResults = res
                case .failure(let err):
                    print(err)
                }
            }
        })
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(showing: .constant(true))
    }
}
