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


}

