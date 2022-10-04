//
//  ListCitiesView.swift
//  Weather
//
//  Created by Fábio Pontes on 04/10/2022.
//

import SwiftUI

struct ListCitiesView: View {
    
    @StateObject private var viewModel = ViewModel()
    @Binding var showing: Bool
    
    var body: some View {
        NavigationView {
            List(viewModel.filterList, id: \.self){ city in
                HStack{
                    Text(city.name ?? "")
                    Text(city.coutry?.emoji ?? "")
                }
                .onTapGesture {
                    viewModel.haveSelected(city: city)
                    showing = false
                }
               
                
            }
            .listStyle(.plain)
            // to avoid large list to be slow,
            //every time that list change, swift go inside each row and compare with the old one row to see if realy change, good for animation.
            // givin a id to a list swift can compare both id instantly...
            .id(UUID())
        }
        .searchable(text: $viewModel.searchText,
                    //placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Write the city name...")
    }
}

extension ListCitiesView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var allCities: [City]
        @Published var searchText = ""
        
        var filterList:[City] {
            if searchText.isEmpty {
                return allCities
            } else {
                return allCities.filter {
                    $0.name?.localizedCaseInsensitiveContains(searchText) ?? false
                }
            }
        }
        
        
        init() {
            allCities = CoreDataManager.shared.fetchCity() // ["aaaa","ssss","dddd","rrdrr","wwww","sss","ggg","hhh","kkk"]
            print(allCities.count)
        }
        
        func haveSelected(city: City){
            print(city.name ?? "")
            CoreDataManager.shared.cleanAndAddCityToUser(city: city)
        }
    }
    
}


//struct ListCitiesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListCitiesView(constant(true))
//    }
//}
