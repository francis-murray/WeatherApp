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
     *   Function that loads the cities from a json file into an array of City objects
     */
    func loadAllCities(jsonFilename: String) -> [City] {
        // read and decode jsonFileURL to Swift objects array with codable
        let jsonFileURL = Constants.documentsDirectory.appendingPathComponent(jsonFilename).appendingPathExtension("json")
        print("Loading cities data from \(jsonFilename).json...");
        if let citiesData = try? Data(contentsOf: jsonFileURL, options: .alwaysMapped),
            let cities = try? JSONDecoder().decode([City].self, from: citiesData) {
                print("Success!");
                return cities;
        } else {
            print("Error loading data from \(jsonFileURL)");
            return [];
        }
    }
    
    
    /*
     *   Function that searches the a file for the the inputed city name and returns the corresponding City object
     */
    func findCity(cityName: String, cities: [City]) -> City?  {
        for city in cities {
            if city.name == cityName {
                return city
            }
        }
        return nil
    }
    

    /*
     *   Function that prompts the user for a city name and returns the corresponding City object
     */
    func getCityFromUser(citiesArray: [City]) -> City? {
        var invalidCity: Bool = true
        var userInput: String
        repeat {
            print("Please enter a city name: ")
            userInput = readLine()!
            if (!userInput.isEmpty) {
                if let tempCity = cityServices.findCity(cityName: userInput, cities: citiesArray) {
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
    func getCitiesFromUser(citiesArray: [City]) -> [City] {
        var cityArray: [City] = []
        var userInput: String
        repeat {
            print("Please add a city name or enter 'q' when your done: ")
            userInput = readLine()!
            if !userInput.isEmpty && userInput != "q" {
                if let city = cityServices.findCity(cityName: userInput, cities: citiesArray) {
                    print("You have entered \(city.name), \(city.country)")
                    cityArray.append(city)
                    print("Current list of cities: ", terminator: "")
                    for city in cityArray {
                        print("\(city.name), \(city.country)", terminator: "; ")
                    }
                    print()
                } else {
                    print("The city \(userInput) you entered could not be found")
                }
            }
        } while(userInput != "q")
        return cityArray
    }
}
