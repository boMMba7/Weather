//
//  WeatherApp.swift
//  Weather
//
//  Created by Fábio Pontes on 01/10/2022.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    init(){
        
        CoreDataManager.shared.load{
            print("Core Data Load Complet")
        }
//        CoreDataManager.shared.CleanAll()
        JsonManager.shared.loadCities()
    }
    
    var body: some Scene {
        WindowGroup {
//            ListCitiesView()
            MainView()
        }
    }
}
