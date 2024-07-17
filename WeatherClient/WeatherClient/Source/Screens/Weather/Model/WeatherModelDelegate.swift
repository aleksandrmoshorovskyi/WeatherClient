//
//  WeatherModelDelegate.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 15.05.2024.
//

import Foundation

protocol WeatherModelDelegate: AnyObject {
    
    func dataDidLoad(with data: WeatherDataModel?)    
    func cityDidLoad(with data: CDWeatherCities?)
}
