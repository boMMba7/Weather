//
//  JsonManager.swift
//  Weather
//
//  Created by Fábio Pontes on 03/10/2022.
//

import Foundation

final class JsonManager {
    
    static let shared = JsonManager()
    private init(){}
    
    var countriesCities = [CountriesCity]()
    
    
    func loadCities() {
        // do this task in backgroun thred , to dont lag or frise the app
        DispatchQueue.global(qos: .background).async {
            if let jsonData = self.getDataFromJasonFile() {
                do {
                    let countriesCities = try JSONDecoder().decode([CountriesCity].self, from: jsonData)
                    // number of countries alredy in core data,
                    // becou the preview insersion could have been,
                    // impturrupted with close of the app
                    let nCountries = CoreDataManager.shared.fetchCountries().count
                    let countriesCitiesDroped = countriesCities.dropFirst(nCountries)
                    // insert in core data
                    for c in countriesCitiesDroped {
                        DispatchQueue.main.async {
                            CoreDataManager.shared.createCountry(name: c.name,
                                                                 longitude: c.longitude ?? "",
                                                                 latitude: c.latitude ?? "",
                                                                 emoji: c.emoji ?? "",
                                                                 cities: c.cities ?? [])
                        }
                    }
                } catch {
                    print("Error trying to decode cities data from jason:\n \(error)")
                }
            }
        }
    }
    
    private func getDataFromJasonFile () -> Data? {
        guard let path = Bundle.main.path(forResource: "CountriesCities",
                                          ofType: "Json") else { return nil}
        let url = URL(filePath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            return jsonData
        } catch {
            print("Error trying to convert Json file to Data:\n \(error)")
        }
        return nil
    }
    
}
