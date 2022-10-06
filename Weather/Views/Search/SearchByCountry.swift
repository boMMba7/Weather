//
//  SearchByCountry.swift
//  Weather
//
//  Created by Fábio Pontes on 06/10/2022.
//

import SwiftUI

struct SearchByCountry: View {
    @StateObject private var viewModel = ViewModel()
    @Binding var showing: Bool
    
    @State var showingCities = true
    
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.filterList){ country in
                    let cities = country.getCities()
                    let vM = ListCitiesView.ViewModel(cities: cities)
                    let countryName = country.name ?? ""
                    let countryEmoji = country.emoji ?? ""
                    let nCity = country.cities?.count ?? 0
                    NavigationLink( destination: ListCitiesView(viewModel: vM, showing: $showing) ) {
                        LazyVStack(alignment: .leading){
                            HStack{
                                Text(countryEmoji)
                                Text(countryName)
                            }
                            Text(" \(nCity) \(nCity < 2 ? "City" : "Cities" )")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                        }
                        .navigationTitle("Select Country")
                    }
                }
            }
            .listStyle(.plain)
            // to avoid large list to be slow,
            //every time that list change, swift go inside each row and compare with the old one row to see if realy change, good for animation.
            // givin a id to a list swift can compare both id instantly...
            .id(UUID())
            
        }
        .searchable(text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search Country...")
    }
}

extension SearchByCountry {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var allCountries: [Country]
        @Published var searchText = ""
        
        var filterList:[Country] {
            if searchText.isEmpty {
                return allCountries
            } else {
                return allCountries.filter {
                    $0.name?.localizedCaseInsensitiveContains(searchText) ?? false
                }
            }
        }
        
        init() {
            allCountries = CoreDataManager.shared.fetchCountries()
            print(("\(allCountries.count) countries"))
        }
        
        func haveSelected(city: City){
            print(city.name ?? "")
            CoreDataManager.shared.cleanAndAddCityToUser(city: city)
        }
    }
    
}

//struct SearchByCountry_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchByCountry(showing: .constant(true))
//    }
//}
