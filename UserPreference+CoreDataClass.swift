//
//  UserPreference+CoreDataClass.swift
//  Weather
//
//  Created by Fábio Pontes on 04/10/2022.
//
//

import Foundation
import CoreData

@objc(UserPreference)
public class UserPreference: NSManagedObject {

    
    func getCities() -> [City] {
        let city = self.city as? Set<City>
        return city?.sorted {
            $0.name ?? "" < $1.name ?? ""
        } ?? []
    }
    
    
    
}
