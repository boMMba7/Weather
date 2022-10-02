//
//  DayView.swift
//  Weather
//
//  Created by Fábio Pontes on 01/10/2022.
//

import SwiftUI

struct DayView: View {
    
    var dayName, imageName: String
    var temperature: String
    
    var body: some View {
        VStack{
            
            Text(dayName)
                .foregroundColor(.white)
            AsyncImageView(imageurl: imageName, width: 40, height: 40)
            Text("\(temperature)º")
                .foregroundColor(.white)
        }
    }
}



struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayName: "name",
                imageName: "https://www.weatherbit.io/static/img/icons/t03d.png",
                temperature: "0")
    }
}
