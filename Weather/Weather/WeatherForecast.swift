//
//  WeatherForecast.swift
//  Weather
//
//  Created by Hao Lam on 6/15/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let cod: String
    let message: Int
    let city: City
    let cnt: Int
    let list: [List]
}

// MARK: - City
struct City: Codable {
    let geonameID: Int
    let name: String
    let lat, lon: Double
    let country, iso2, type: String
    let population: Int

    enum CodingKeys: String, CodingKey {
        case geonameID = "geoname_id"
        case name, lat, lon, country, iso2, type, population
    }
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let temp: Temp
    let pressure: Double
    let humidity: Int
    let weather: [Weather]
    let speed: Double
    let deg, clouds: Int
    let rain, snow: Double?
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: Main
    let weatherDescription: Description
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum Main: String, Codable {
    case clear = "Clear"
    case rain = "Rain"
}

enum Description: String, Codable {
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case skyIsClear = "sky is clear"
}
