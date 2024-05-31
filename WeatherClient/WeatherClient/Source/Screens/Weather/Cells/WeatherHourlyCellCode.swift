//
//  WeatherHourlyCellCode.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 31.05.2024.
//

import UIKit

class WeatherHourlyCellCode: UICollectionViewCell {

    static let idintifier = "WeatherHourlyCellCode"
    
    var dataSource: [HourlyForecast]!
    var collectionView: UICollectionView!
    
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
        
        //containerView.backgroundColor = .lightGray
        
        // MARK: collectionView setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
    
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = Constant.mainCollectionViewColor
        //collectionView.isPagingEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            UINib(nibName: WeatherHourlyDetailCell.idintifier, bundle: nil),
            forCellWithReuseIdentifier: WeatherHourlyDetailCell.idintifier)
        
        collectionView.register(
            WeatherHourlyDetailCellCode.self,
            forCellWithReuseIdentifier: WeatherHourlyDetailCellCode.idintifier
        )
    }
    
    func setupLayout() {

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            // MARK: collectionView constraints
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .zero)
        ])
    }
    
    func getIconByCode(_ code: String) -> String {
        
        //debugPrint("\(code)")
        
        switch code {
        case "01d":
            return "☀️"
        case "02d":
            return "🌤️"
        case "03d":
            return "🌥️"
        case "04d":
            return "☁️"
        case "09d":
            return "🌧️"
        case "10d":
            return "🌦️"
        case "11d":
            return "⛈️"
        case "13d":
            return "❄️"
        case "50d":
            return "🌫️"
            
        case "01n":
            return "🌕"
        case "02n":
            return "☁️"
        case "03n":
            return "☁️"
        case "04n":
            return "☁️"
        case "09n":
            return "🌧️"
        case "10n":
            return "🌦️"
        case "11n":
            return "⛈️"
        case "13n":
            return "❄️"
        case "50n":
            return "🌫️"
            
        default:
            debugPrint("\(code)")
            return "🚫"
        }
    }
}


