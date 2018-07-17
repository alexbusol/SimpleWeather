//
//  DataModel.swift
//  SimpleWeather
//
//  Created by Alex Busol on 7/16/18.
//  Copyright © 2018 Alex Busol. All rights reserved.
//

//
//  WeatherDataModel.swift
//  WeatherApp

//

import UIKit

class WeatherDataModel {
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = "" //holds the city name
    var weatherIconName : String = "" //needed to show custom images
    var customBackground : String = "" //needed to show custom backgrounds
    var weatherState : String = ""

    func getWeatherCondition() -> String {
        return weatherState
    }
    
    
    //This method turns a condition code that we get from openweathermap into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            weatherState = "There's a thunderstorm outside"
            return "thunder"
            
        case 301...500 :
            weatherState = "There's some lihgt rain"
            return "rain-light"
            
        case 501...600 :
            weatherState = "It's raining today"
            return "rain"
            
        case 601...700 :
            weatherState = "It's snowing"
            return "snow"
            
        case 701...771 :
            weatherState = "The weather is mostly cloudy today."
            return "little-sun"
            
        case 772...799 :
            weatherState = "Oh my, there's some volcanic activity in your area!"
            return "thunder"
            
        case 800 :
            weatherState = "The sky is clear and the weather is nice :)"
            return "sunny"
            
        case 801...802 :
            weatherState = "There are some light clouds in the sky"
            return "little-cloudy"
            
        case 803...804 :
            weatherState = "The sky is covered in clouds"
            return "cloudy"
    
            
        default :
            return "unknown"
        }
        
    }
}

