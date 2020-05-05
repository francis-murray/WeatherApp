//
//  helperFunctions.swift
//  WeatherApp
//
//  Created by Francis Murray on 5/5/20.
//  Copyright © 2020 Francis Murray & Massyl Djemai. All rights reserved.
//

import Foundation
    
func displayMenu() -> String {
    var usersChoice: String
    repeat {
        print()
        print("************************   MENU   ***************************")
        print("*  Please select an option from below:                      *")
        print("*  1 - Get current weather conditions for a city            *")
        print("*  2 - Get current weather conditions for a list of cities  *")
        print("*  3 - Get 5 day weather forecast for city                  *")
        print("*  4 - Quit                                                 *")
        print("*************************************************************")
        usersChoice = readLine()!
    } while(usersChoice != "1" && usersChoice != "2" && usersChoice != "3" && usersChoice != "4")
    return usersChoice
}

