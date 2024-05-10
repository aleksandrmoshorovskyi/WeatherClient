//
//  MainModel.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import Foundation

class MainModel {
    
    //only for test
    let city = "Dnipro"
    let location = Location(latitude: 49.989619, longitude: 36.241182)
    let parametrs = (units: Units.metric, lang: Lang.ua)
    var value: String = "" //Variable 'self' was written to, but never read
    
    
    weak var delegate: MainModelDelegate?
    
    let networkService: NetworkServiceWeather
    //let storageService: CoreDataWeather
    
    init(delegate: MainModelDelegate? = nil) {
        self.delegate = delegate
        self.networkService = ServiceProvider.networkService()
        //self.storageService = ServiceProvider.coreDataService()
    }
}

// MARK: - MainModelProtocol
extension MainModel: MainModelProtocol {
    
    func loadData() {
        networkService.loadWeatherForCity(city, with: parametrs) { [weak self] weatherInfo, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let weather = weatherInfo  {
                //debugPrint("\(weather.)")
                self?.value = "\(weather.name)"
                //self?.mainLabel.text = "\(weather.name)"
                self?.delegate?.dataDidLoad(with: weather)
            }
        }
    }
}
