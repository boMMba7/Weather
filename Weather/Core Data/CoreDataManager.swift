//
//  CoreDataManager.swift
//  Weather
//
//  Created by Fábio Pontes on 03/10/2022.
//


import Foundation
import CoreData

class CoreDataManager{
    
    // a pointer to the core data
    static let shared = CoreDataManager(modelName: "Weather")
    
    let persistentContainer: NSPersistentContainer
    var myContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    //completion: if want to do sonthing after load sucefull
    func load(completion: (() ->Void)? = nil) {
        persistentContainer.loadPersistentStores {
            (description, error) in guard error == nil else{
                fatalError(error!.localizedDescription)
            }
            //let know if have completed load sucefull
            completion?()
        }
        
        let countries = fetchCountries()
        print(" number of countries in core data: \(countries.count)")
    }
    
    
    // save the changes maid in the core data
    func save() {
        if self.myContext.hasChanges{
            do{
                try self.myContext.save()
            } catch {
                print("An error ocurred while saving: \(error)")
            }
        }
    }
    
    func fetchCity(filter: String? = nil) -> [City]{
        let request: NSFetchRequest<City> = City.fetchRequest()
        
        // if recive a argumnet will filter the fetch with specific filter
        if let filter = filter {
            let predicate = NSPredicate(format: "name contains[cd] %@", filter)
            request.predicate = predicate
        }
        do{
            return try self.myContext.fetch(request)
        } catch {
            print("An error ocurred while fetching: \(error.localizedDescription)")
            return []
        }
    }
    
    // return the especific categorys on data core, if don exist return []
    func fetchExateCountry(filter: String? = nil) -> [Country] {
        let request: NSFetchRequest<Country> = Country.fetchRequest()
        if let filter = filter {
                let predicate = NSPredicate(format: "name = %@", filter)
            request.predicate = predicate
        }
        do{
            return try self.myContext.fetch(request)
        } catch {
            print("An error ocurred while fetching: \(error.localizedDescription)")
            return []
        }
    }
    
    
    //return all countries that math whit filter, case note return []
    func fetchCountries(filter: String? = nil) -> [Country] {
        let request: NSFetchRequest<Country> = Country.fetchRequest()
        if let filter = filter {
                let predicate = NSPredicate(format: "name contains[cd] %@", filter)
            request.predicate = predicate
        }
        do{
            return try self.myContext.fetch(request)
        } catch {
            print("An error ocurred while fetching: \(error.localizedDescription)")
            return []
        }
    }
    
    func CoreDataIsEmpty() -> Bool {
        let countries = fetchCountries()
        print(" number of countries in core data: \(countries.count)")
        for country in countries {
            print("\(country.emoji ?? "") \(country.name ?? "") with \(country.cities?.count ?? 0) cities")
        }
       
        return countries.isEmpty
    }
    
    func CleanAll() {
        let countries = fetchCountries()
        print(" number of countries in core data: \(countries.count)")
        for country in countries {
            print("\(country.name ?? "") ----- DELETED ")
            self.myContext.delete(country)
        }
        save()
        print(" number of countries in core data: \(countries.count)")
    }
    
  
}

// MARK:- Helper functions
extension CoreDataManager{
    
    private func createCity(name: String,
                            longitude: String,
                            latitude: String ) -> City {
        
        let city = City(context: self.myContext)
        city.name = name
        city.longitude = longitude
        city.latitude = latitude
        save()
        return city
    }
    
    func createCountry(name: String? = "No Country",
                       longitude: String,
                       latitude: String,
                        emoji: String,
                       cities: [JsonCity]) -> Country {
        
        let coutry = Country(context: self.myContext)
        coutry.name = name
        coutry.latitude = latitude
        coutry.longitude = longitude
        coutry.emoji = emoji

        for c in cities {
            let city = createCity(name: c.name ?? "",
                                  longitude: c.longitude ?? "" ,
                                  latitude: c.latitude ?? "" )
            coutry.addToCities(city)
        }
        print("Creating country: \(coutry.name ?? "NO NAME") with \(coutry.cities?.count ?? 0) cities")
        save()
        return coutry
    }
    
}
