//
//  WeatherHourlyDetailCellCode.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 31.05.2024.
//

import UIKit

class WeatherHourlyDetailCellCode: UICollectionViewCell {
    
    static let idintifier = "WeatherHourlyDetailCellCode"
    
    var stackView: UIStackView!
    
    var hourLabel: UILabel!
    var iconImage: UIImageView!
    var iconLabel: UILabel!
    var detailLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        self.backgroundColor = Constant.weatherTopCellBackgroundColor
        contentView.backgroundColor = Constant.weatherTopCellContentViewColor
        
        //containerView.backgroundColor = Constant.weatherTopCellContainerViewColor
        
        //hourLabel
        hourLabel = UILabel()
        hourLabel.textColor = .white
        
        //hourLabel
        iconImage = UIImageView()
        iconImage.contentMode = .scaleAspectFit //small pic
        iconImage.contentMode = .scaleAspectFill //big pic
        iconImage.tintColor = .systemYellow
        
        //iconLabel
        iconLabel = UILabel()
        
        //detailLabel
        detailLabel = UILabel()
        detailLabel.textColor = .white
        
        // MARK: - stackView config
        stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        //view.addSubview(stackView)
        
        stackView.addArrangedSubview(hourLabel)
        //stackView.addArrangedSubview(iconImage)
        stackView.addArrangedSubview(iconLabel)
        stackView.addArrangedSubview(detailLabel)
    }
    
    func setupLayout() {

        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // MARK: collectionView constraints
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .zero)
        ])
    }
}
