//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Fábio Pontes on 02/10/2022.
//

import SwiftUI

struct CurrentWeatherView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        
        Text(viewModel.weather.name)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding(.all, 60.0)
        
        VStack(spacing: 8){
            AsyncImageView(imageurl: viewModel.weather.imageUrl, width: 100, height: 100)
            
            Text("\(viewModel.weather.temperature)º")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

//  MVVM
extension CurrentWeatherView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var weather = WetherStruct()
        
        var city: City? {
            CoreDataManager.shared.getUserPrefence()?.getCity()
        }
        
        init() {
           updateCurrentWeather()
        }
        
        //  fetch information from api, when done,
        //  put the information in brodcast variable,
        //  to update the view that are lisening
        private func updateCurrentWeather() {
            let lat = city?.latitude ?? "53.8008"
            let long = city?.longitude ?? "1.5491"
            print("\(city?.coutry?.emoji ?? "XX") \(city?.coutry?.name ?? "XX") \(city?.name ?? "XX")     \(lat)      \(long)")
            NetWorkManager.shared.currentWeather(lat: lat,
                                                 long: long,
                                                 completion: { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result{
                    case .success(let current):
                        let emoji = self?.city?.coutry?.emoji ?? ""
                        let cityName = current.data?.first?.cityName ?? ""
                        self?.weather = WetherStruct(name: "\(cityName)  \(emoji)",
                                                     imageUrlCode: current.data?.first?.weather?.icon ?? "",
                                                     temperature: current.data?.first?.temp ?? 0)
                       
                    case .failure(let err):
                        print(err)
                    }
                }
            })
        }
    }
}


struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
    }
}
