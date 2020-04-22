//
//  main.swift
//  WeatherApp
//
//  Created by Francis Murray on 4/22/20.
//  Copyright © 2020 Francis Murray & Massyl Djemai. All rights reserved.
//

import Foundation

print("Hello, World!")
let API_KEY = "75be34154e6ffc7c6e01c7cc07b69a96"

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

struct WeatherReport: Codable {
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let clouds: Clouds
}

let query: [String: String] = [
    "q" : "Paris",
    "appid" : API_KEY
]


extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        return components?.url
    }
}

let baseURL = URL(string: "http://api.openweathermap.org/data/2.5/weather")!
let url = baseURL.withQueries(query)!
print("url: ", url)

let task = URLSession.shared.dataTask(with: url) {
    (data, response, error) in
    let jsonDecoder = JSONDecoder()
    if let data = data,
        let weatherReport = try? jsonDecoder.decode(WeatherReport.self, from: data) {
        print(weatherReport)
    }
    else {
        print("The API response could not be decoded")
    }
}
task.resume()


RunLoop.main.run()

