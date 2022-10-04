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
                
                Spacer()
                ForecastView()
                .padding(.all)
                Spacer()
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
        
        init() {
            // if dont have user creat one
            user = CoreDataManager.shared.getUserPrefence() ??
                        CoreDataManager.shared.createUser(name: UIDevice.current.name)
            city = user.getCity()
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
