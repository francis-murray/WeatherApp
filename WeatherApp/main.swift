//
//  main.swift
//  WeatherApp
//
//  Created by Francis Murray on 4/22/20.
//  Copyright © 2020 Francis Murray & Massyl Djemai. All rights reserved.
//

import Foundation

let weatherServices = WeatherServices()
let cityServices = CityServices()



print("Welcome to the WeatherApp!")



var usersChoice: String
repeat {
    print("************************   MENU   ***************************")
    print("*  Please select an option from below:                      *")
    print("*  1 - Get current weather conditions for a city            *")
    print("*  2 - Get current weather conditions for a list of cities  *")
    print("*  3 - Get 5 day weather forecast for city                  *")
    print("*************************************************************")
    usersChoice = readLine()!
} while(usersChoice != "1" && usersChoice != "2" && usersChoice != "3")



switch usersChoice {
    case "1":
        print("You chose menu 1 - Get current weather conditions for a city")
        if let city = cityServices.getCityFromUser() {
            weatherServices.searchCurrentWeatherByCityId(cityId: String(city.id)).resume()
        }
    
    case "2":
        print("You chose menu 2 - Get current weather conditions for a list of cities")
        let citiesArray = cityServices.getCitiesFromUser()
        let citiesIds = citiesArray.map { String($0.id) }
        weatherServices.searchCurrentWeatherByCityIds(cityIds: citiesIds).resume()
    
    case "3":
        print("You chose value 3 - Get 5 day weather forecast for city")
        if let city = cityServices.getCityFromUser() {
            print("Here is the 5 day weather forecast for \(city.name), \(city.country)")
            weatherServices.searchFiveDayWeatherByCityId(cityId: String(city.id)).resume()
        }
    default:
        print("Error, this choice is not in the menu")
}


RunLoop.main.run()
