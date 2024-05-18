//
//  WeatherViewProtocol.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import Foundation

protocol WeatherViewProtocol {
    
    func setupWeather(data: Weather)
    func reloadWeatherData()
}
