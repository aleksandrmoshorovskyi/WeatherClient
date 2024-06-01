//
//  WeatherFeelsLikeCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import UIKit

class WeatherFeelsLikeCell: WeatherBaseCell {
    
    var valueLabel: UILabel!
    
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
        valueLabel = UILabel()
        valueLabel.textColor = Constant.baseCellTextColor
        valueLabel.font = Constant.baseCellTextFont
    }
    
    func setupLayout() {
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //contentView.addSubview(valueLabel) //.alpha = 0.5
        addSubview(valueLabel) //.alpha = 1
        
        NSLayoutConstraint.activate([
            //valueLabel
            valueLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}
