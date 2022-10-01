//
//  DayView.swift
//  Weather
//
//  Created by Fábio Pontes on 01/10/2022.
//

import SwiftUI

struct DayView: View {
    let forecast: Forecast

    var body: some View {
        VStack{
            
            Text(forecast.dayName)
                .foregroundColor(.white)
            Image(systemName: forecast.image.rawValue)
                .renderingMode(.original)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(forecast.temperature)º")
                .foregroundColor(.white)
        }
        
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(forecast: Forecast())
    }
}
