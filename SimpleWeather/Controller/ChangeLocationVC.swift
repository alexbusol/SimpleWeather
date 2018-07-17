//
//  ChangeLocationVC.swift
//  SimpleWeather
//
//  Created by Alex Busol on 7/16/18.
//  Copyright © 2018 Alex Busol. All rights reserved.
//

import UIKit

protocol ChangeLocationDelegate {
    func cityNameEntered(cityName: String)
}

class ChangeLocationVC: UIViewController{

    var delegate : ChangeLocationDelegate?
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBAction func getWeatherPressed(_ sender: UIButton) {
        
        let cityName = cityTextField.text! //always will have info, therefore !
        delegate?.cityNameEntered(cityName: cityName) //pasing value into the cityNameEntered function in MainViewController
        dismiss(animated: true, completion: nil) //dismissing the current view controller
    
    }
    
}
