//
//  SecondView.swift
//  Climatty
//
//  Created by Kateryna Tsysarenko on 01/10/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit

class CityView: UIView {

    private let bgView = UIImageView(image: UIImage(named: "cityBackground"))
    private let textView = UITextField()
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
        addSubview(textView)
        addSubview(button)
        
        bgView.edgesToSuperview()
        bgView.contentMode = .scaleAspectFill
        
        textView.topToSuperview(offset: 100)
        textView.size(CGSize(width: 150, height: 40))
        textView.centerXToSuperview()
        textView.font = .systemFont(ofSize: 20)
        textView.backgroundColor = .white
        textView.textContentType = .location
        textView.textAlignment = .center
        textView.placeholder = "Enter city name"
        
        button.topToBottom(of: textView, offset: 20)
        button.size(CGSize(width: 200, height: 50))
        button.centerXToSuperview()
        button.setTitle("Get Weather", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .white
    }

    func getCityName() -> String? {
        return textView.text
    }
}
