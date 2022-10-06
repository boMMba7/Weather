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
                Button {
                    viewModel.ShowListCities(show: true)
                } label: {
                    
                    Text("Change City")
                        .font(.system(size: 24, weight: .medium, design: .default))
                        .tint(.white)
                        .minimumScaleFactor(0.5)
                        .frame(width: 330, height: 60,alignment: .center)
                        .background(.linearGradient(Gradient(colors: [.clear, .green]),
                                                    startPoint: .bottom,
                                                    endPoint: .top))
                        .cornerRadius(12)
                        .shadow(color: Color(.green), radius: 9, x: 5, y: 10)
                }
                Spacer()
            }
            .popover(isPresented: $viewModel.isVisible ){
                SearchByCountry(showing: $viewModel.isVisible)
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
