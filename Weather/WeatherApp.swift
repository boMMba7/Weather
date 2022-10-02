//
//  WeatherApp.swift
//  Weather
//
//  Created by Fábio Pontes on 01/10/2022.
//

import SwiftUI

@main
struct WeatherApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
