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
     Search current weather conditions for a single city
     */
    //func searchCurrentWeatherByCityId(cityId: String) -> URLSessionDataTask {
    //
    //    let query: [String: String] = [
    //        "id" : cityId,
    //        "appid" : Constants.API_KEY
    //    ]
    //
    //    let endPointURL = .appendingPathComponent("weather")
    //    let url = endPointURL.withQueries(query)!
    //
    //    let task = URLSession.shared.dataTask(with: url) {
    //        (data, response, error) in
    //        let jsonDecoder = JSONDecoder()
    //        if let data = data,
    //            let weatherReport = try? jsonDecoder.decode(WeatherReport.self, from: data) {
    //            print(weatherReport.weather)
    //        }
    //        else {
    //            print("The API response could not be decoded")
    //        }
    //    }
    //    return task
    //}


    func searchCurrentWeatherByCityIds(cityIds: [String]) -> URLSessionDataTask {
        let query: [String: String] = [
            "id" : cityIds.joined(separator: ","),
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
                    print(weatherReport.weather)
                }
            }
            else {
                print("The API response could not be decoded")
            }
        }
        return task
    }



    /*
     Search 5 day weather forecast for a single city
     */
    func searchFiveDayWeatherByCityId(cityId: String) -> URLSessionDataTask {

        let query: [String: String] = [
            "id" : cityId,
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
                    print(Date(timeIntervalSince1970: weatherReport.dt))
                    print(weatherReport.main.feels_like)
                }
            }
            else {
                print("The API response could not be decoded")
            }
        }
        return task
    }

}

    
    

