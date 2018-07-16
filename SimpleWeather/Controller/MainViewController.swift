//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Alex Busol on 7/16/18.
//  Copyright © 2018 Alex Busol. All rights reserved.
//

import UIKit
import CoreLocation //used for determining user's location
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController, CLLocationManagerDelegate {
    //API links:
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "6eadaf273a536bfe04601969558990de"
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting up core location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Gettting the location via location manager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1] //getting the most recent location.
        
        if location.horizontalAccuracy > 0 { //making sure that the value we are getting is not invalid.
            locationManager.stopUpdatingLocation()
            print("longitude: \(location.coordinate.longitude)", "latitude: \(location.coordinate.latitude)" )
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude) //converting to string for the api call.
            
            let params : [String : String] = ["lat":latitude, "lon":longitude, "appid":APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityName.text = "Location Error"
    }
    
    //making a request to the API to get the weather data based on our location
    func getWeatherData(url: String, parameters: [String: String]) {
        
    }
    

}

