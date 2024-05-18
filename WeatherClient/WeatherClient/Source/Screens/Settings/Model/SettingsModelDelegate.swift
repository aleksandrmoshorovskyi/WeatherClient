//
//  SettingsModelDelegate.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

protocol SettingsModelDelegate: AnyObject {
    
//    func citiesDidLoad(with cities: [citiesTuple])
//    func dataDidLoad(with data: [citiesTuple])
    func citiesDidLoad(with cities: [City])
    func dataDidLoad(with data: [City])
}

