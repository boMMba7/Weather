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
    
    
    /// cut the decimal zeros
    /// - Parameter temp: the original double with zeros
    /// - Returns: String that represent the number without the zeros
   private func cutZeros( temp: Double?) -> String {
        if let t = temp {
            let roundDouble = String(format: "%g", t)
            return roundDouble
        } else {
            return "0"
        }
    }
    
    /// convert string representing the date to a corespondent day of the week
    /// - Parameter yyyymmdd: date in string format
    /// - Returns: day of the week of that date
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
