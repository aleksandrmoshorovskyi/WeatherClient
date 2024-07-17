//
//  SettingsViewDelegate.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

protocol SettingsViewDelegate: AnyObject {
    
    func cityRowDidTapAt(_ indexPath: IndexPath)
    func cityRowDeleteAt(_ city: CityDataModel)
    func swapAt(_ sourceCity: CityDataModel, _ destinationCity: CityDataModel)
}

