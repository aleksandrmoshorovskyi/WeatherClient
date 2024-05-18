//
//  SettingsView+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

extension SettingsView: SettingsViewProtocol {

    func setupCities(data: [City]) {
        
        citiesDataSource = data
        citiesTableView.reloadData()
    }
    
    func setupWeather(data: [City]) {
        
        citiesDataSource = data
        citiesTableView.reloadData()
    }
}
