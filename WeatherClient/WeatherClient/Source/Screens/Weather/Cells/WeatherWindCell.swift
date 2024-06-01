//
//  WeatherWindCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import UIKit

class WeatherWindCell: WeatherBaseCell {
    
    var stackView: UIStackView!
    
    var windDegLabel: UILabel!
    var spacingLabel: UILabel!
    var windSpeedLabel: UILabel!
    var windGustLabel: UILabel!
    
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
        windDegLabel = UILabel()
        windDegLabel.textColor = Constant.baseCellTextColor
        windDegLabel.font = Constant.baseCellTextFont
        
        //spacingLabel
        spacingLabel = UILabel()
        spacingLabel.textColor = Constant.baseCellTextColor
        spacingLabel.font = Constant.baseCellTextFont
        spacingLabel.text = " "
        
        //valueLabel
        windSpeedLabel = UILabel()
        windSpeedLabel.textColor = Constant.baseCellTextColor
        windSpeedLabel.font = Constant.windCellTextFont
        
        //valueLabel
        windGustLabel = UILabel()
        windGustLabel.textColor = Constant.baseCellTextColor
        windGustLabel.font = Constant.windCellTextFont
        
        //stackView config
        stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .center
        //stackView.distribution = .fillEqually
        //stackView.spacing = 15
        
        stackView.addArrangedSubview(windDegLabel)
        stackView.addArrangedSubview(spacingLabel)
        stackView.addArrangedSubview(windSpeedLabel)
        stackView.addArrangedSubview(windGustLabel)
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
