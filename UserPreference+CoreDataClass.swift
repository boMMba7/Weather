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

    func getCity() -> City? {
        let city = self.city as? Set<City>
        return city?.first
    }
    
}
