//
//  WeatherViewController+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import UIKit

// MARK: - WeatherViewDelegate
extension WeatherViewController: WeatherViewDelegate {
    
}

// MARK: - WeatherModelDelegate
extension WeatherViewController: WeatherModelDelegate {
    
    func dataDidLoad(with data: Weather) {
        //debugPrint("dataDidLoad - \(data.name)")
        
        dataSource = data
        
        
        //setupData()
        //let tempStr = String(format: "%.0f" , data.main.temp)
        //label?.text = "\(tempStr) ℃"
        
        //if let dataA = data {
            contentView?.setupWeather(data: data)
        //}
    }
}
