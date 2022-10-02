//
//  MainView.swift
//  Weather
//
//  Created by Fábio Pontes on 01/10/2022.
//

import SwiftUI

struct MainView: View {
    
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
