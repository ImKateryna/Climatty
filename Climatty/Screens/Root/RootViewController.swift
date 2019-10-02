//
//  ViewController.swift
//  Climatty
//
//  Created by Kateryna Tsysarenko on 30/09/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class RootViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    let myView = RootView()
    
    private let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    private let APP_ID = "aa64577eba18bf5ab9cefef5ff1064c3"
    
    private let locationManager = CLLocationManager()
    private let weatherDataModel = WeatherDataModel()
    
    override func loadView() {
        super.loadView()
        
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        myView.button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Weather"        
    }
    
    
    //MARK: Request weather
    
    func getWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { respons in
            if respons.result.isSuccess {
                //print(respons)
                
                let weatherJSON: JSON = JSON(respons.result.value!)
                self.updateWeatherData(weatherJSON)
                
            } else {
                print("Error", respons.result.error as Any)
                self.myView.setupLocation("Connection problems")
            }
        }
        
    }
    
    // MARK: JSON Parsing
    
    fileprivate func updateWeatherUI() {
        myView.setupLocation(weatherDataModel.city)
        myView.setupTemperature(temperature: weatherDataModel.temperature)
        myView.setupIcon(iconName: weatherDataModel.weatherIconName)
    }
    
    func updateWeatherData(_ json: JSON) {
        if let tempResult = json["main"]["temp"].double {
            let cityResult = json["name"].stringValue
            let weatherConditionResult = json["weather"][0]["id"].intValue
            
            weatherDataModel.setTemperature(temperature: tempResult)
            weatherDataModel.setCity(city: cityResult)
            weatherDataModel.setWeatherCondition(weatherCondition: weatherConditionResult)
            print(weatherDataModel.city)
            updateWeatherUI()
            
        } else {
            myView.setupLocation("Weather is unavailable")
        }
    }
    
    //MARK: Location Manager Delegate Methods
    
    // didUpdateLocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params: [String : String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    // didFailWithError
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        myView.setupLocation("Location Unavaliable")
        
    }
    
    @objc private func buttonPressed(_ sender: Any) {
        print("Pressed")
        
        let destinationVC = CityViewController()
        destinationVC.delegate = self
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func userEnteredNewCityName(city: String) {
        let params : [String : String] = ["q": city, "appid": APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
}
