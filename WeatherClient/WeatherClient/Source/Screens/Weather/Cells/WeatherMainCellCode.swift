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
    var citySmallLabel: UILabel!
    var tempLabel: UILabel!
    var weatherDescLabel: UILabel!
    
    var tempMinLabel: UILabel!
    var tempMaxLabel: UILabel!
    
    var stackViewHL: UIStackView!
    
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
        contentView.backgroundColor = .clear
        
        //containerView setup
        containerView = UIView()
        containerView.backgroundColor = .clear //Constant.containerViewColor
        
        //cityNameLabel
        cityNameLabel = UILabel()
        cityNameLabel.textColor = Constant.baseCellTextColor
        cityNameLabel.font = UIFont.systemFont(ofSize: 40)
        
        //citySmallLabel
        citySmallLabel = UILabel()
        citySmallLabel.textColor = Constant.baseCellTextColor
        
        //tempLabel
        tempLabel = UILabel()
        tempLabel.textColor = Constant.baseCellTextColor
        tempLabel.font = UIFont.systemFont(ofSize: 90)
        
        //weatherDescLabel
        weatherDescLabel = UILabel()
        weatherDescLabel.textColor = Constant.baseCellTextColor
        weatherDescLabel.font = UIFont.systemFont(ofSize: 25)
        
        //tempLabel
        tempMaxLabel = UILabel()
        tempMaxLabel.textColor = Constant.baseCellTextColor
        //tempMaxLabel.font = UIFont.systemFont(ofSize: 20)
        
        //tempLabel
        tempMinLabel = UILabel()
        tempMinLabel.textColor = Constant.baseCellTextColor
        //tempMinLabel.font = UIFont.systemFont(ofSize: 20)
        
        //for TEST backgroundColor = .red
        //cityNameLabel.backgroundColor = .red
        //citySmallLabel.backgroundColor = .red
        //tempLabel.backgroundColor = .red
        //weatherDescLabel.backgroundColor = .red
        //tempMaxLabel.backgroundColor = .red
        //tempMinLabel.backgroundColor = .red
        
        //stackViewHL config
        stackViewHL = UIStackView()
        stackViewHL.axis = NSLayoutConstraint.Axis.horizontal
        stackViewHL.alignment = .center
        stackViewHL.distribution = .fillEqually
        stackViewHL.spacing = 5
        
        stackViewHL.addArrangedSubview(tempMaxLabel)
        stackViewHL.addArrangedSubview(tempMinLabel)
        
        //stackView config
        stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .center
        //stackView.distribution = .fillEqually
        //stackView.spacing = 10
        
        stackView.addArrangedSubview(cityNameLabel)
        stackView.addArrangedSubview(citySmallLabel)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(weatherDescLabel)
        stackView.addArrangedSubview(stackViewHL)
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
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}
