//
//  weatherServices.swift
//  WeatherApp
//
//  Created by Francis Murray on 4/30/20.
//  Copyright © 2020 Francis Murray & Massyl Djemai. All rights reserved.
//

import Foundation

class WeatherServices {

    /*
     * Function that searches the current weather conditions for a city
     * using the OpenWeatherApp API and returns the corresponding URLSessionDataTask
     */
    func searchCurrentWeatherByCityId(cityId: String) -> URLSessionDataTask {
        let query: [String: String] = [
            "id" : cityId,
            "units": Constants.UNITS,
            "appid" : Constants.API_KEY
        ]
        let endPointURL = Constants.BASE_URL.appendingPathComponent("weather")
        let url = endPointURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let weatherReport = try? jsonDecoder.decode(WeatherReport.self, from: data) {
                    if let name = weatherReport.name, let country = weatherReport.sys.country {
                        print("Weather in \(name), \(country)", terminator: ": ")
                    }
                    print("\(weatherReport.weather[0].description), temperature: \(weatherReport.main.temp), feels like: \(weatherReport.main.feels_like)")
            }
            else {
                print("The API response could not be decoded")
            }
        }
        return task
    }

    
    /*
     * Function that searches the current weather conditions for a list of cities
     * using the OpenWeatherApp API and returns the corresponding URLSessionDataTask
     */
    func searchCurrentWeatherByCityIds(cityIds: [String]) -> URLSessionDataTask {
        let query: [String: String] = [
            "id" : cityIds.joined(separator: ","),
            "units": Constants.UNITS,
            "appid" : Constants.API_KEY
        ]
        let endPointURL = Constants.BASE_URL.appendingPathComponent("group")
        let url = endPointURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let weatherReports = try? jsonDecoder.decode(WeatherReports.self, from: data) {
                for weatherReport in weatherReports.list {
                    if let name = weatherReport.name, let country = weatherReport.sys.country {
                        print("Weather in \(name), \(country)", terminator: ": ")
                    }
                    print("\(weatherReport.weather[0].description), temperature: \(weatherReport.main.temp), feels like: \(weatherReport.main.feels_like)")
                }
            }
            else {
                print("The API response could not be decoded")
            }
        }
        return task
    }


    /*
     * Function that searches the 5 day weather forecast for a single city
     * using the OpenWeatherApp API and returns the corresponding URLSessionDataTask
     */
    func searchFiveDayWeatherByCityId(cityId: String) -> URLSessionDataTask {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        let query: [String: String] = [
            "id" : cityId,
            "units": Constants.UNITS,
            "appid" : Constants.API_KEY
        ]
        let endPointURL = Constants.BASE_URL.appendingPathComponent("forecast")
        let url = endPointURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let weatherReports = try? jsonDecoder.decode(WeatherReports.self, from: data) {
                for weatherReport in weatherReports.list {
                    let date = Date(timeIntervalSince1970: weatherReport.dt)
                    print(dateFormatter.string(from: date), terminator: ": ")
                    print("\(weatherReport.weather[0].description), temperature: \(weatherReport.main.temp), feels like: \(weatherReport.main.feels_like)")
                }
            }
            else {
                print("The API response could not be decoded")
            }
        }
        return task
    }
}
