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
        if CoreDataManager.shared.CoreDataIsEmpty() {
            if let jsonData = getDataFromJasonFile() {
                do {
                    countriesCities = try JSONDecoder().decode([CountriesCity].self, from: jsonData)
                    print(countriesCities.first!.latitude!)
                    print(countriesCities.first!.emojiU!)
                    
                    for c in countriesCities {
                        CoreDataManager.shared.createCountry(name: c.name,
                                                             longitude: c.longitude ?? "",
                                                             latitude: c.latitude ?? "",
                                                             emoji: c.emojiU ?? "",
                                                             cities: c.cities ?? [])
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
