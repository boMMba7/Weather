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
        .onReceive(CoreDataManager.shared.getUserPrefence()!.objectWillChange) { _ in
            viewModel.updateCityDisplayed()
        }
    }
}

//  MARK :-     MVVM
extension ForecastView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var forecasts = [WetherStruct]()
        @Published var city = CoreDataManager.shared.getUserPrefence()?.getCities().first
        
        init(){
           updateForecast()
        }
        
        func updateCityDisplayed() {
            city = CoreDataManager.shared.getUserPrefence()?.getCities().first
            updateForecast()
        }
        
        //  fetch information from api, when done,
        //  put the information in brodcast variable,
        //  to update the view that are lisening
        private func updateForecast() {
            let lat = city?.latitude ?? "53.8008"
            let long = city?.longitude ?? "1.5491"
            
            NetWorkManager.shared.forecat(lat: lat, long: long) { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let forecast):
                        self?.populate(forecast: forecast.data ?? [])
                    case .failure(let err):
                        print(err)
                    }
                }
            }
        }
        
        /// put the information fethed in a collection of  broadcast variable
        /// - Parameter forecast: collection of data recived from api
        private func populate(forecast: [DatumForecast]){
            self.forecasts.removeAll()
            if !forecast.isEmpty {
                for i in  1...5{
                    let fCast = WetherStruct(name: forecast[i].validDate ?? "Day",
                                             imageUrlCode: forecast[i].weather?.icon ?? "",
                                             temperature: forecast[i].temp ?? 0)
                    self.forecasts.append(fCast)
                }
            }
        }
    }
}


struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
