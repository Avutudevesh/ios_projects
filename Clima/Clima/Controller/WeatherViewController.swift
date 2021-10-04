//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationmanager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
    }
    
    
    @IBAction func onSearchClicked(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    
    @IBAction func onFetchLocationClicked(_ sender: UIButton) {
        print("clicked")
        locationmanager.requestLocation()
    }
    
    
    
}

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = String(weather.temperature)
            self.cityLabel.text = weather.city
            self.conditionImageView.image = UIImage(systemName: weather.weatherData, withConfiguration: nil)
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let lat = location?.coordinate.latitude ?? 0.0
        let lon = location?.coordinate.longitude ?? 0.0
        weatherManager.fetchWeatherData(lat: String(lat), lon: String(lon))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed")
        print(error)
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            textField.placeholder = "Type something"
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        weatherManager.fetchWeatherData(city: textField.text!)
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
