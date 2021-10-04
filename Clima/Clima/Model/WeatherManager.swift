//
//  WeatherManager.swift
//  Clima
//
//  Created by Devesh Avutu on 06/07/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate? = nil
    
    
    var baseUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=00b74452d77dc6f0a35173b5535c8438&units=metric"
    
    func fetchWeatherData(city: String) {
        let currentUrl = baseUrl+"&q=\(city)"
        
        if let url = URL(string: currentUrl) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let weather = self.parseJson(data: safeData)
                    if let safeWeather = weather{
                        self.delegate?.didUpdateWeather(weather: safeWeather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func fetchWeatherData(lat: String, lon: String) {
        let currentUrl = baseUrl+"&lat=\(lat)&lon=\(lon)"
        print(currentUrl)
        if let url = URL(string: currentUrl) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let weather = self.parseJson(data: safeData)
                    if let safeWeather = weather{
                        self.delegate?.didUpdateWeather(weather: safeWeather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let temperature = decodedData.main.temp
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let weatherModel = WeatherModel(weatherId: id, temperature: temperature, city: cityName)
            return weatherModel
        } catch {
            print(error)
            return nil
        }
    }
    
    
}


