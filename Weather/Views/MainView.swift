//
//  MainView.swift
//  Weather
//
//  Created by Fábio Pontes on 01/10/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        
        ZStack{
            BackGroundView(tooColor: .blue, bottonColor: Color("lightBlue"))
            VStack{
                CurrentWeatherView()
                    .onTapGesture {
                        viewModel.ShowListCities(show: true)
                    }
                
                Spacer()
                ForecastView()
                .padding(.all)
                Spacer()
            }
            .popover(isPresented: $viewModel.isVisible ){
                ListCitiesView(showing: $viewModel.isVisible)
            }
            .onReceive(CoreDataManager.shared.getUserPrefence()!.objectWillChange) { _ in
                viewModel.updateCityDisplayed()
                print("User mudou a cidade \(viewModel.city?.name ?? "")")
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.all)
        
    }
}

extension MainView {
    
    @MainActor private final class ViewModel: ObservableObject{
        
        @Published private(set) var user: UserPreference
        @Published private(set) var city: City?
        @Published var isVisible = false

        init() {
            // if dont have user creat one
            user = CoreDataManager.shared.getUserPrefence() ??
                        CoreDataManager.shared.createUser(name: UIDevice.current.name)
            city = user.getCities().first
        }
        
        func ShowListCities(show: Bool) {
            isVisible = show
        }
        
        func updateCityDisplayed() {
            city = user.getCities().first
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
