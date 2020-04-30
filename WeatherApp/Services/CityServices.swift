//
//  CityServices.swift
//  WeatherApp
//
//  Created by Francis Murray on 4/30/20.
//  Copyright © 2020 Francis Murray & Massyl Djemai. All rights reserved.
//

import Foundation

class CityServices {
    /*
     Function that finds a city by its name and return a City object
     */
    func findCity(cityName: String, jsonFileURL: URL) -> City?  {
        // read and decode jsonFileURL to Swift objects array with codable
        if let retrievedData = try? Data(contentsOf: jsonFileURL), let cities = try? JSONDecoder().decode([City].self, from: retrievedData) {
            for city in cities {
                if city.name == cityName {
                    return city
                }
            }
        } else {
            print("The data from \(jsonFileURL) could not be decoded")
        }
        return nil
    }
}
