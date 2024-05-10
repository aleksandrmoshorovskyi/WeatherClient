//
//  MainViewController+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import Foundation

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    
    func cityDidTap() {
//        model.loadData()
    }
}

// MARK: - MainModelDelegate
extension MainViewController: MainModelDelegate {
    
    //func dataDidLoad(with data: CDWeatherInfo) {
    func dataDidLoad(with data: DMWeatherInfo) {
        let dataToShow =  "\(data.main.temp)"
        contentView.setupWeather(text: dataToShow)
        contentView.setupWeather(data: data)
    }
}
