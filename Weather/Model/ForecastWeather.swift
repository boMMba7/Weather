// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecastWeather = try? newJSONDecoder().decode(ForecastWeather.self, from: jsonData)

import Foundation

// MARK: - ForecastWeather
struct ForecastWeather: Codable {
    let data: [DatumForecast]?
    let lon, lat: Double?
    let timezone, countryCode, stateCode, cityName: String?

    enum CodingKeys: String, CodingKey {
        case data, lon, lat, timezone
        case countryCode = "country_code"
        case stateCode = "state_code"
        case cityName = "city_name"
    }
}

// MARK: - Datum
struct DatumForecast: Codable {
    let minTemp: Double?
    let snowDepth, pop: Int?
    let ozone, maxTemp, lowTemp, highTemp: Double?
    let cloudsLow: Int?
    let pres: Double?
    let clouds: Int?
    let vis, windSpd: Double?
    let windCdirFull: String?
    let slp: Double?
    let datetime: String?
    let ts: Int?
    let dewpt, moonPhase: Double?
    let moonsetTs, windDir: Int?
    let validDate: String?
    let moonriseTs: Int?
    let moonPhaseLunation, precip: Double?
    let windCdir: String?
    let weather: Weather?
    let windGustSpd, temp, appMinTemp, appMaxTemp: Double?
    let uv: Double?
    let cloudsMid, rh, cloudsHi, sunsetTs: Int?
    let maxDhi: JSONNull?
    let snow, sunriseTs: Int?

    enum CodingKeys: String, CodingKey {
        case minTemp = "min_temp"
        case snowDepth = "snow_depth"
        case pop, ozone
        case maxTemp = "max_temp"
        case lowTemp = "low_temp"
        case highTemp = "high_temp"
        case cloudsLow = "clouds_low"
        case pres, clouds, vis
        case windSpd = "wind_spd"
        case windCdirFull = "wind_cdir_full"
        case slp, datetime, ts, dewpt
        case moonPhase = "moon_phase"
        case moonsetTs = "moonset_ts"
        case windDir = "wind_dir"
        case validDate = "valid_date"
        case moonriseTs = "moonrise_ts"
        case moonPhaseLunation = "moon_phase_lunation"
        case precip
        case windCdir = "wind_cdir"
        case weather
        case windGustSpd = "wind_gust_spd"
        case temp
        case appMinTemp = "app_min_temp"
        case appMaxTemp = "app_max_temp"
        case uv
        case cloudsMid = "clouds_mid"
        case rh
        case cloudsHi = "clouds_hi"
        case sunsetTs = "sunset_ts"
        case maxDhi = "max_dhi"
        case snow
        case sunriseTs = "sunrise_ts"
    }
}

// MARK: - Weather
//struct Weather: Codable {
//    let code: Int?
//    let icon, weatherDescription: String?
//
//    enum CodingKeys: String, CodingKey {
//        case code, icon
//        case weatherDescription = "description"
//    }
//}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
