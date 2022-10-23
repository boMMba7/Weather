// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let currentWeather = try? newJSONDecoder().decode(CurrentWeather.self, from: jsonData)

import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let data: [Datum]?
    let count: Int?
}

// MARK: - Datum
struct Datum: Codable {
    let aqi: Double?
    let dni: Double?
    let windCdir: String?
    let rh: Double?
    let pod: String?
    let lon: Double?
    let pres: Double?
    let timezone, station, countryCode: String?
    let clouds, vis: Double?
    let windSpd: Double?
    let cityName, windCdirFull: String?
    let ts, snow: Double?
    let hAngle, dewpt, uv: Double?
    let windDir: Double?
    let elevAngle, ghi, dhi: Double?
    let precip: Double?
    let weather: Weather?
    let stateCode, sunset: String?
    let temp: Double?
    let sunrise: String?
    let appTemp: Double?
    let solarRAD: Double?
    let obTime: String?
    let sources: [String]?
    let slp: Double?
    let datetime: String?
    let lat: Double?

    enum CodingKeys: String, CodingKey {
        case aqi, dni
        case windCdir = "wind_cdir"
        case rh, pod, lon, pres, timezone, station
        case countryCode = "country_code"
        case clouds, vis
        case windSpd = "wind_spd"
        case cityName = "city_name"
        case windCdirFull = "wind_cdir_full"
        case ts, snow
        case hAngle = "h_angle"
        case dewpt, uv
        case windDir = "wind_dir"
        case elevAngle = "elev_angle"
        case ghi, dhi, precip, weather
        case stateCode = "state_code"
        case sunset, temp, sunrise
        case appTemp = "app_temp"
        case solarRAD = "solar_rad"
        case obTime = "ob_time"
        case sources, slp, datetime, lat
    }
}

// MARK: - Weather
struct Weather: Codable {
    let weatherDescription: String?
    let code: Int?
    let icon: String?
    
    
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case code, icon
    }
}
