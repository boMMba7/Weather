//
//  Country+CoreDataClass.swift
//  Weather
//
//  Created by Fábio Pontes on 04/10/2022.
//
//

import Foundation
import CoreData

@objc(Country)
public class Country: NSManagedObject {
    
    func getCities() -> [City] {
        let city = self.cities as? Set<City>
        return city?.sorted {
            $0.coutry?.name ?? "" < $1.coutry?.name ?? ""
        } ?? []
    }
    
}
