//
//  Forecast.swift
//  Weather
//
//  Created by Fábio Pontes on 02/10/2022.
//

import SwiftUI

struct ForecastView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
       
        HStack(spacing: 20){
          
            ForEach(viewModel.forecasts, id: \.self){ fCast in
                DayView(dayName: fCast.name,
                        imageName: fCast.imageUrl,
                        temperature: fCast.temperature)
            }
          
        }
    }
}

extension ForecastView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var forecasts = [WetherStruct]()
        
        init(){
           updateForecast()
        }
        
        private func updateForecast() {
            NetWorkManager.shared.forecat(cityName: "Accra") { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let forecast):
//                        print(forecast)
                        self?.populate(forecast: forecast.data ?? [])
                        
    
                    case .failure(let err):
                        print(err)
                    }
                }
                
            }
        }
        
        private func populate(forecast: [DatumForecast]){
            for i in  1...5{
                let fCast = WetherStruct(name: forecast[i].validDate ?? "Day",
                                         imageUrlCode: forecast[i].weather?.icon ?? "",
                                         temperature: forecast[i].temp ?? 0)
                forecasts.append(fCast)
            }
        }
    }
}


struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
