//
//  MainModel.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import Foundation

class MainModel {
    
    //var cities: [WeatherViewController] = []
    
    weak var delegate: MainModelDelegate?
    
    let networkService: NetworkServiceWeather
    let storageService: CoreDataCity
    
    init(delegate: MainModelDelegate? = nil) {
        self.delegate = delegate
        self.networkService = ServiceProvider.networkService()
        self.storageService = ServiceProvider.coreDataService()
    }
}
