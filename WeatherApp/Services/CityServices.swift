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
        let jsonFileURL = Constants.documentsDirectory.appendingPathComponent(jsonFilename)
            .appendingPathExtension("json")
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
     *   Function that looks for all the cities with a specified prefix,
     *   and returns a list of these cities objects
     */
    func findCitiesWithPrefix(prefix: String, cities: [City]) -> [City]?  {
        var results: [City] = []
        for city in cities {
            if city.name.starts(with: prefix)  {
                results.append(city)
            }
        }
        if results.isEmpty {
            return nil
        }
        return results
    }
    
    
    /*
     *   Function that prompts the user to select a city from a list of cities,
     *   and returns that City object
     */
    func selectCityFromCities(cities: [City]) -> City? {
        var userIndex: Int?
        if cities.count > 1 {
            var cityIndex = 1
            for city in cities {
                if (!city.state.isEmpty) {
                    print("\(cityIndex): \(city.name), \(city.state), \(city.country)")
                } else {
                    print("\(cityIndex): \(city.name), \(city.country)")
                }
                cityIndex += 1
            }
            print("There are \(cities.count) cities matching or starting with that name.")
            print("Please enter the index of the city you're looking for:")
            repeat {
                userIndex = Int(readLine()!)
                if userIndex == nil {
                    print("Invalid entry. Please enter a numeric value for the index")
                } else if !(1...cityIndex-1).contains(userIndex!) {
                    print("Invalid entry. Please enter a number within the index range")
                }
            } while (userIndex == nil || !(1...cityIndex-1).contains(userIndex!))
        } else {
            userIndex = 0
        }
        print("You have chosen \(cities[userIndex!-1].name), \(cities[userIndex!-1].country)")
        return cities[userIndex!-1]
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
            if let cities = cityServices.findCitiesWithPrefix(prefix: userInput, cities: citiesArray) {
                if let selectedCity = selectCityFromCities(cities: cities) {
                    return selectedCity
               }
            } else {
                print("Sorry, the city \"\(userInput)\" could not be found. Please try again")
                invalidCity = true
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
                if let cities = cityServices.findCitiesWithPrefix(prefix: userInput, cities: citiesArray) {
                    if let selectedCity = selectCityFromCities(cities: cities) {
                        cityArray.append(selectedCity)
                        print("Current list of cities: ", terminator: "")
                        for city in cityArray {
                            if (!city.state.isEmpty) {
                                print("\(city.name), \(city.state), \(city.country)", terminator: "; ")
                            } else {
                                print("\(city.name), \(city.country)", terminator: "; ")
                            }
                        }
                        print("")
                    }
                } else {
                    print("Sorry, the city \"\(userInput)\" could not be found. Please try again")
                }
            }
        } while(userInput != "q" || cityArray.isEmpty)
        return cityArray
    }
}
