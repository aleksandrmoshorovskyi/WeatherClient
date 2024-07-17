//
//  WeatherModel.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 15.05.2024.
//

import Foundation

class WeatherModel {
    
    //move to settings {
    let parametrs = (units: Units.metric, lang: Lang.ua)
    //}

    weak var delegate: WeatherModelDelegate?
    
    let networkService: NetworkServiceWeather
    let storageService: CoreDataServiceProtocol
    
    init(delegate: WeatherModelDelegate? = nil) {
        self.delegate = delegate
        self.networkService = ServiceProvider.networkService()
        self.storageService = ServiceProvider.coreDataService()
    }
}
