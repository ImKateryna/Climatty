//
//  RootView.swift
//  Climatty
//
//  Created by Kateryna Tsysarenko on 30/09/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import TinyConstraints

class RootView: UIView {
    
    private let bgView = UIImageView(image: UIImage(named: "background"))
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let iconContainer = UIView()
    private let iconView = UIImageView()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        
        addSubview(bgView)
        addSubview(cityLabel)
        addSubview(temperatureLabel)
        addSubview(button)
        addSubview(iconContainer)
        iconContainer.addSubview(iconView)

        bgView.edgesToSuperview()
        
        button.topToSuperview(offset: 60)
        button.trailingToSuperview(offset: 15)
        button.setImage(UIImage(named: "switch"), for: .normal)
        
        cityLabel.text = "Loading..."
        cityLabel.textColor = .white
        cityLabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        cityLabel.bottomToSuperview(offset: -100)
        cityLabel.leadingToSuperview(offset: 50)

        temperatureLabel.font = UIFont.systemFont(ofSize: 60, weight: UIFont.Weight.medium)
        temperatureLabel.textColor = .white
        temperatureLabel.topToBottom(of: button, offset: 30)
        temperatureLabel.trailingToSuperview(offset: 20)
        temperatureLabel.textAlignment = .right
        
        iconContainer.topToBottom(of: temperatureLabel)
        iconContainer.bottomToTop(of: cityLabel)
        
        iconView.contentMode = .scaleAspectFit
        iconView.centerYToSuperview()
        iconView.centerX(to: self)
        iconView.height(128)
        iconView.width(128)
    }
    
    func setupLocation(_ city: String) {
        cityLabel.text = city
    }
    
    func setupTemperature(temperature: Int) {
        temperatureLabel.text = "\(temperature)°"
    }
    
    func setupIcon(iconName: String) {
        iconView.image = UIImage(named: iconName)
    }

}
