//
//  SecondViewController.swift
//  Climatty
//
//  Created by Kateryna Tsysarenko on 01/10/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import TinyConstraints

class CityViewController: UIViewController {
    
    let myView = CityView()
    var delegate: ChangeCityDelegate?
    
    override func loadView() {
        super.loadView()
        
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Check"
        
        myView.button.addTarget(self, action: #selector(getWeatherPressed), for: UIControl.Event.touchUpInside)
    }
    
    @objc func getWeatherPressed(_ sender: AnyObject) {
        if let cityName = myView.getCityName() {
            
            delegate?.userEnteredNewCityName(city: cityName)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

}
