//
//  WeatherView+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import Foundation

// MARK: - MainViewProtocol
extension WeatherView: WeatherViewProtocol {
    
    func setupCancelButton() {
        cancelButton.isHidden = false
    }
    
    func setupAddButton() {
        addButton.isHidden = false
    }
    
    
//    func setupControls() {
//        setupButtons()
//    }
    
    func reloadWeatherData() {
        collectionView.reloadData()
    }
    
    func setupWeather(data: Weather) {
        dataSource = data
        collectionView.reloadData()
    }
}
