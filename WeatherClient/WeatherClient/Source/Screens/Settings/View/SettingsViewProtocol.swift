//
//  SettingsViewProtocol.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

protocol SettingsViewProtocol {
    
//    func setupCities(data: [citiesTuple])
//    func setupWeather(data: [citiesTuple])
    func setupCities(data: [City])
    func setupWeather(data: [City])
    
    func settingsBarButtonAction()
}

