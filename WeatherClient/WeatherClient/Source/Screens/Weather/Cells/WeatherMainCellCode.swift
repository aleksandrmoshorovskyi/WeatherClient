//
//  WeatherMainCellCode.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import UIKit

class WeatherMainCellCode: UICollectionViewCell {
    
    var containerView: UIView!
    var stackView: UIStackView!
    
    var cityNameLabel: UILabel!
    var tempLabel: UILabel!
    var weatherDescLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBaseUI()
        setupBaseLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBaseUI() {
        
        self.backgroundColor = Constant.baseCellBackgroundColor
        
        //contentView setup
        contentView.layer.cornerRadius = Constant.weatherCellCornerRadius
        contentView.backgroundColor = Constant.contentViewColor
        contentView.alpha = Constant.contentViewAlpha
        
        //containerView setup
        containerView = UIView()
        containerView.backgroundColor = Constant.containerViewColor
        
        //cityNameLabel
        cityNameLabel = UILabel()
        cityNameLabel.textColor = Constant.baseCellTextColor
        
        //tempLabel
        tempLabel = UILabel()
        tempLabel.textColor = Constant.baseCellTextColor
        
        //weatherDescLabel
        weatherDescLabel = UILabel()
        weatherDescLabel.textColor = Constant.baseCellTextColor
        
        // MARK: - stackView config
        stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        stackView.addArrangedSubview(cityNameLabel)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(weatherDescLabel)
    }
    
    func setupBaseLayout() {
        
        //titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        //.alpha = 0.5
        //contentView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        
        //.alpha = 1
        //addSubview(titleLabel)
        //addSubview(containerView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            //collectionView constraints
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .zero),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .zero),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .zero),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .zero),
            
            //stackView constraints
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .zero),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: .zero),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .zero),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: .zero)
        ])
    }
}
