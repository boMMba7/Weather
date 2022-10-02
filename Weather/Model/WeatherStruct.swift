//
//  WeatherStruct.swift
//  Weather
//
//  Created by Fábio Pontes on 02/10/2022.
//

import Foundation

struct WetherStruct: Hashable {
    
    private var _name, imageUrlCode: String
    private var temp: Double
    
    // return days of the week or return the city
    var name: String {
        return dayOfTheWeek(yyyymmdd: _name) ?? _name
    }
    
    var temperature: String {
        get{
            return cutZeros(temp: temp)
        }
    }
    
    var imageUrl: String {
        return "https://www.weatherbit.io/static/img/icons/\(imageUrlCode).png"
    }
    
    init(name: String = "", imageUrlCode: String = "" , temperature: Double = 0) {
        self._name = name
        self.imageUrlCode = imageUrlCode
        self.temp = temperature
    }
    
    
   private func cutZeros( temp: Double?) -> String {
        if let t = temp {
            let roundDouble = String(format: "%g", t)
            return roundDouble
        } else {
            return "0"
        }
    }
    
    private func dayOfTheWeek (yyyymmdd: String) -> String? {
        let weekDays = ["Sun",
                        "Mon",
                        "Tue",
                        "Wed",
                        "Thu",
                        "Fri",
                        "Sat"]
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        guard let date = formatter.date(from: yyyymmdd) else { return nil }
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: date)
        return weekDays[weekDay - 1]
    }
    
}
