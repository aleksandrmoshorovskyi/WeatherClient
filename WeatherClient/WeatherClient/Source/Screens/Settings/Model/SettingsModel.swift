//
//  SettingsModel.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

class SettingsModel {
    
    //var cities: [CityWeatherModel] = []
    
    //must be from settings
    let parametrs = (units: Units.metric, lang: Lang.ua)
    
    weak var delegate: SettingsModelDelegate?
    
    let networkService: NetworkServiceWeather
    let storageService: CoreDataServiceProtocol
    
    init(delegate: SettingsModelDelegate? = nil) {
        self.delegate = delegate
        self.networkService = ServiceProvider.networkService()
        self.storageService = ServiceProvider.coreDataService()
    }
}
