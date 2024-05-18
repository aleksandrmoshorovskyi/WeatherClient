//
//  MainViewProtocol.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import Foundation

protocol MainViewProtocol {
    
    func setupWeather(data: [WeatherViewController])
    func setupCurrentPageAt(_ indexPath: IndexPath)
}
