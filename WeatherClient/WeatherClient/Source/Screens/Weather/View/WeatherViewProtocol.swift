//
//  WeatherViewProtocol.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import Foundation

protocol WeatherViewProtocol {
    
    func setupWeather(data: WeatherDataModel)
    func reloadWeatherData()
    
    //func setupControls()
    
    func setupCancelButton()
    func setupAddButton()
}
