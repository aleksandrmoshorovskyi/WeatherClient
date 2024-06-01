//
//  WeatherSunRiseSetCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import UIKit

class WeatherSunRiseSetCell: WeatherBaseCell {
    
    var stackView: UIStackView!
    
    var sunsetLabel: UILabel!
    var sunriseLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        //valueLabel
        sunsetLabel = UILabel()
        sunsetLabel.textColor = Constant.baseCellTextColor
        sunsetLabel.font = Constant.baseCellTextFont
        
        //valueLabel
        sunriseLabel = UILabel()
        sunriseLabel.textColor = Constant.baseCellTextColor
        sunriseLabel.font = .systemFont(ofSize: 15)
        
        //stackView config
        stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        
        stackView.addArrangedSubview(sunsetLabel)
        stackView.addArrangedSubview(sunriseLabel)
    }
    
    func setupLayout() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //contentView.addSubview(valueLabel) //.alpha = 0.5
        addSubview(stackView) //.alpha = 1
        
        NSLayoutConstraint.activate([
            //stackView
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}
