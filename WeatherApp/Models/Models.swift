//
//  Models.swift
//  WeatherApp
//
//  Created by Francis Murray on 4/30/20.
//  Copyright © 2020 Francis Murray & Massyl Djemai. All rights reserved.
//

import Foundation


/*
 * Global constants
 */

struct Constants {
    static let BASE_URL = URL(string: "http://api.openweathermap.org/data/2.5")!
    static let API_KEY = "75be34154e6ffc7c6e01c7cc07b69a96"
    static let UNITS = "metric"
    static let DEGREE_SYMB = "°C"
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let jsonFileURL = documentsDirectory.appendingPathComponent("city.list.min").appendingPathExtension("json")
}


/*
 * city.list.json data Models
 */
struct Coord: Codable {
    let lon: Float
    let lat: Float
}

struct City: Codable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: Coord
}


/*
 * OpenWeatherMap API data Models
 */
struct WeatherReports: Codable {
    let cnt: Int
    let list: [WeatherReport]
}

struct WeatherReport: Codable {
    let name: String?
    let sys: Sys
    let dt: Double
    let weather: [Weather]
    let main: Main
    let visibility: Int? // Optional value, only for 5 day forecast
    let clouds: Clouds
}

struct Sys: Codable {
    let country: String?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Float
    let humidity: Float
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Float
    let deg: Float
}


public extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        return components?.url
    }
}
