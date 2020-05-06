//
//  helperFunctions.swift
//  WeatherApp
//
//  Created by Francis Murray on 5/5/20.
//  Copyright © 2020 Francis Murray & Massyl Djemai. All rights reserved.
//

import Foundation
    
/*
*   Function that displays the top level menu
*/
func displayMenu() -> String {
    var usersChoice: String
    print()
    print("************************   MENU   ***************************")
    print("*  Please select an option from below:                      *")
    print("*  1 - Get current weather conditions for a city            *")
    print("*  2 - Get current weather conditions for a list of cities  *")
    print("*  3 - Get 5 day weather forecast for city                  *")
    print("*  4 - Quit                                                 *")
    print("*************************************************************")
    print()
    usersChoice = readLine()!
    return usersChoice
}


/*
*   Function that matches Emojis to the API icons codes
*/
func weatherEmoji(icon: String) -> String {
    switch icon {
        // day icons
        case "01d": return "☀️"
        case "02d": return "🌤"
        case "03d": return "🌥"
        case "04d": return "☁️"
        case "09d": return "🌧"
        case "10d": return "🌦"
        case "11d": return "🌩"
        case "13d": return "❄️"
        case "50d": return "🌫"

        // night icons - no "night" emojis available, so used the same as for the daytime
        case "01n": return "☀️"
        case "02n": return "🌤"
        case "03n": return "🌥"
        case "04n": return "☁️"
        case "09n": return "🌧"
        case "10n": return "🌦"
        case "11n": return "🌩"
        case "13n": return "❄️"
        case "50n": return "🌫"
        default: return "N/A"
     }
}


/*
 *   Function that displays the table header for the weather forecast
 */
func printForecastTableHeader() {
    print("Date ".padding(toLength: 29, withPad: " ", startingAt: 0)
        + "Description ".padding(toLength: 25, withPad: " ", startingAt: 0)
        + "Temperature".padding(toLength: 18, withPad: " ", startingAt: 0)
        + "Feels like")
    print("".padding(toLength: 83, withPad: "-", startingAt: 0))
}


/*
*   Function that displays the weather forecast reports in a clean table format
*/
func printForecastToTableFormat(weatherReport: WeatherReport) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US") // US English Locale (en_US)
    
        let date = Date(timeIntervalSince1970: weatherReport.dt)
        print("\(dateFormatter.string(from: date))".padding(toLength: 29, withPad: " ", startingAt: 0)
            + "\(weatherEmoji(icon: weatherReport.weather[0].icon))"
            + " \(weatherReport.weather[0].description) ".padding(toLength: 23, withPad: " ", startingAt: 0)
            + "\(weatherReport.main.temp)\(Constants.DEGREE_SYMB) ".padding(toLength: 18, withPad: " ", startingAt: 0)
            + "\(weatherReport.main.feels_like)\(Constants.DEGREE_SYMB)")
}


/*
*   Function that displays the table header for the current weather for one or multiple cities
*/
func printCityTableHeader() {
    print("\nCity, Country ".padding(toLength: 29, withPad: " ", startingAt: 0)
        + "Description ".padding(toLength: 25, withPad: " ", startingAt: 0)
        + "Temperature".padding(toLength: 18, withPad: " ", startingAt: 0)
        + "Feels like")
    print("".padding(toLength: 83, withPad: "-", startingAt: 0))
}


/*
*   Function that displays the cities weather reports in a clean table format
*/
func printCityToTableFormat(weatherReport: WeatherReport) {
    if let name = weatherReport.name, let country = weatherReport.sys.country {
        print("\(name), \(country)".padding(toLength: 28, withPad: " ", startingAt: 0), terminator: "")
    }
    print("\(weatherEmoji(icon: weatherReport.weather[0].icon))"
            + " \(weatherReport.weather[0].description) ".padding(toLength: 23, withPad: " ", startingAt: 0)
            + "\(weatherReport.main.temp)\(Constants.DEGREE_SYMB) ".padding(toLength: 18, withPad: " ", startingAt: 0)
            + "\(weatherReport.main.feels_like)\(Constants.DEGREE_SYMB)")
}
