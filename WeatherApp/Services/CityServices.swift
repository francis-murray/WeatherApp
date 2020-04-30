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
     *   Function that prompts the user for a city name and returns the corresponding City object
     */
    func getCityFromUser() -> City? {
        var invalidCity: Bool = true
        var userInput: String
        repeat {
            print("Please enter a city name: ")
            userInput = readLine()!
            if (!userInput.isEmpty) {
                if let tempCity = cityServices.findCity(cityName: userInput, jsonFileURL: Constants.jsonFileURL) {
                    return tempCity
                } else {
                    print("The city \(userInput) could not be found. Please try again")
                    invalidCity = true
                }
            }
        } while(userInput.isEmpty || invalidCity)
        return nil
    }

    
    /*
     *   Function that prompts the user for a list of cities and returns an array of corresponding City objects
     */
    func getCitiesFromUser() -> [City] {
        var cityArray: [City] = []
        var userInput: String
        repeat {
            print("Please enter a city name: ")
            userInput = readLine()!
            if !userInput.isEmpty {
                if let city = cityServices.findCity(cityName: userInput, jsonFileURL: Constants.jsonFileURL) {
                    print("You have entered \(city.name), \(city.country)")
                    cityArray.append(city)
                    print("List of cities: ", terminator: "")
                    for city in cityArray {
                        print("\(city.name), \(city.country)", terminator: "; ")
                    }
                    print()
                } else {
                    print("The city \(userInput) you entered could not be found")
                }

                print("Enter another city? (y/n)")
                userInput = readLine()!
            }
        } while(userInput != "n")
        return cityArray
    }
    
    
    /*
     *   Function that searches the a file for the the inputed city name and returns the corresponding City object
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
