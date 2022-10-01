//
//  MainView.swift
//  Weather
//
//  Created by Fábio Pontes on 01/10/2022.
//

import SwiftUI

struct MainView: View {
    
    var cityName = "Leeds"
    var todayTemperature = 20
    var todayImage: WeatherImageName = .CLOUDSUN
    
    @State var forecast1: Forecast = Forecast()
    @State var forecast2: Forecast = Forecast(dayName: "Mon", temperature: 20, image: .SUN)
    @State var forecast3: Forecast = Forecast(dayName: "Tue", temperature: 15, image: .RAIN)
    @State var forecast4: Forecast = Forecast(dayName: "Wen", temperature: 19, image: .SUN)
    @State var forecast5: Forecast = Forecast(dayName: "Thu", temperature: 18, image: .CLOUDSUN)
    
    
    var body: some View {
        
        ZStack{
           BackGroundView(tooColor: .blue, bottonColor: Color("lightBlue"))
            VStack{
                Text(cityName)
                    .font(.system(size: 32, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(.all, 60.0)
                
                VStack(spacing: 8){
                    Image(systemName: todayImage.rawValue)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                    
                    Text("\(todayTemperature)º")
                        .font(.system(size: 70, weight: .medium))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 20){
                        DayView(forecast: forecast1)
                        DayView(forecast: forecast2)
                        DayView(forecast: forecast3)
                        DayView(forecast: forecast4)
                        DayView(forecast: forecast5)
                       
                    }
                    .padding(.all)
                    Spacer()
                }
               
            }
            .edgesIgnoringSafeArea(.all)
            
        }
        .ignoresSafeArea(.all)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
