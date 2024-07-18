//
//  SettingsViewProtocol.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

protocol SettingsViewProtocol {
    
    func setupCities(data: [CityWeatherDataModel])
    func setupWeather(data: [CityWeatherDataModel])
    func settingsBarButtonAction()
}

