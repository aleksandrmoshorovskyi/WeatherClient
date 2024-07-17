//
//  SettingsView+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

extension SettingsView: SettingsViewProtocol {
    
    func settingsBarButtonAction() {
        
        citiesTableView.isEditing = !citiesTableView.isEditing
    }

    func setupCities(data: [CityWeatherDataModel]) {
        
        citiesWithWeather = data
        citiesTableView.reloadData()
    }
    
    func setupWeather(data: [CityWeatherDataModel]) {
        
        citiesWithWeather = data
        citiesTableView.reloadData()
    }
}
