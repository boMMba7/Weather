//
//  DayView.swift
//  Weather
//
//  Created by Fábio Pontes on 01/10/2022.
//

import SwiftUI

struct DayView: View {
    
    @StateObject private var viewModel = ViewModel()
    
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

extension DayView {
    @MainActor class ViewModel: ObservableObject {
//        @Published private(set) var forecast = Forecast()
        
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayName: "name", imageName: "sun.max.fill", temperature: "0")
    }
}
