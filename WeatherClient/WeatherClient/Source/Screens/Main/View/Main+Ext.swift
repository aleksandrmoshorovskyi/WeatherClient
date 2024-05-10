//
//  Main+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import Foundation

// MARK: - MainViewProtocol
extension MainView: MainViewProtocol {
    
    func setupWeather(text: String) {
        label.text = text
        
        data = text
    }
}
