//
//  ChangeLocationVC.swift
//  SimpleWeather
//
//  Created by Alex Busol on 7/16/18.
//  Copyright © 2018 Alex Busol. All rights reserved.
//

import UIKit

class WeatherDataModel {
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = "" //holds the city name
    var weatherIconName : String = "" //needed to show custom images
    var customBackground : String = "" //needed to show custom backgrounds
    //Declare your model variables here
    
    
    //This method turns a condition code that we get from openweathermap into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "unknown"
        }
        
    }
}

