//
//  main.swift
//  WeatherApp
//
//  Created by Francis Murray on 4/22/20.
//  Copyright © 2020 Francis Murray & Massyl Djemai. All rights reserved.
//

import Foundation

let weatherServices = WeatherServices()
let cityServices: CityServices = CityServices()
let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let jsonFileURL = documentsDirectory.appendingPathComponent("city_tiny.list").appendingPathExtension("json")
var cityId: String = ""
var citiesIdsArray: [String] = []
var cityName: String

print("Welcome to the WeatherApp!")


repeat {
    print("Please enter a city name and enter q when you're done: ")
    cityName = readLine()!
    if let city = cityServices.findCity(cityName: cityName, jsonFileURL: jsonFileURL) {
        cityId = String(city.id)
        citiesIdsArray.append(cityId)
    } else {
        print("The city \(cityName) you entered could not be found")
    }
    print("citiesIdsArray so far...: \(citiesIdsArray)")
} while(cityName.isEmpty || cityName != "q")



print("citiesIdsArray[0]: \(citiesIdsArray[0])")
weatherServices.searchFiveDayWeatherByCityId(cityId: citiesIdsArray[0]).resume()
RunLoop.main.run()











/*
Search one city
 */
//if let city = findCity(cityName: cityName, jsonFileURL: jsonFileURL) {
//    cityId = String(city.id)
//    searchCurrentWeatherByCityId(cityId: cityId).resume()
//    RunLoop.main.run()
//} else {
//    print("The city \(cityName) could not be found")
//}

