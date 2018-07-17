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

class MainViewController: UIViewController, CLLocationManagerDelegate, ChangeLocationDelegate {
    //API links:
    let WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather"
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
    
    //MARK: - Working with the API
    //making a request to the API to get the weather data based on our location
    func getWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                print("Error: \(response.result.error)")
                self.cityName.text = "Connection Error"
            }
        }
    }
    
    //MARK: - JSON Parsing
    
    func updateWeatherData(json: JSON) {
        if let tempResult = json["main"]["temp"].double { //pulls out the temperature value from the JSON.
            weatherDataModel.temperature = Int(tempResult - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUI()
        }
        else {
            cityName.text = "Coudln't fetch the weather"
        }
    }
    
    func updateUI() {
        cityName.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature)+"℃"
        weatherImage.image = UIImage(named: weatherDataModel.weatherIconName)
        weatherCondition.text = weatherDataModel.getWeatherCondition()
       // backgroundImage.image = UIImage(named: weatherDataModel.weatherIconName + "BG")
       // backgroundImage.image = UIImage(named: "sunnyBG")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeLocationVC //the datatype of segue destination
            destinationVC.delegate = self
        }
    }
    
    func cityNameEntered(cityName: String) {
        //  print(city)
        let params : [String : String] = ["q" : cityName, "appID" : APP_ID] //q is the key specified in  the API
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
}

