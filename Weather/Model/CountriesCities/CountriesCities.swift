// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let countriesCities = try? newJSONDecoder().decode(CountriesCities.self, from: jsonData)

import Foundation

// MARK: - CountriesCity
struct CountriesCity: Codable, Identifiable {
    let id: Int?
    let name, iso3, iso2, numericCode: String?
    let phoneCode, capital, currency, currencyName: String?
    let currencySymbol, tld: String?
    let native: String?
    let region: Region?
    let subregion: String?
    let timezones: [Timezone]?
    let translations: Translations?
    let latitude, longitude, emoji, emojiU: String?
    let cities: [JsonCity]?

    enum CodingKeys: String, CodingKey {
        case id, name, iso3, iso2
        case numericCode = "numeric_code"
        case phoneCode = "phone_code"
        case capital, currency
        case currencyName = "currency_name"
        case currencySymbol = "currency_symbol"
        case tld, native, region, subregion, timezones, translations, latitude, longitude, emoji, emojiU, cities
    }
}

// MARK: - City
struct JsonCity: Codable, Identifiable {
    let id: Int?
    let name, latitude, longitude: String?
    let country: CountriesCity?  // just contain _id name and emoji
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case asia = "Asia"
    case empty = ""
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}

// MARK: - Timezone
struct Timezone: Codable {
    let zoneName: String?
    let gmtOffset: Int?
    let gmtOffsetName, abbreviation, tzName: String?
}

// MARK: - Translations
struct Translations: Codable {
    let kr, ptBR, pt, nl: String?
    let hr, fa, de, es: String?
    let fr, ja, it, cn: String?
    let tr: String?

    enum CodingKeys: String, CodingKey {
        case kr
        case ptBR = "pt-BR"
        case pt, nl, hr, fa, de, es, fr, ja, it, cn, tr
    }
}

typealias CountriesCities = [CountriesCity]
