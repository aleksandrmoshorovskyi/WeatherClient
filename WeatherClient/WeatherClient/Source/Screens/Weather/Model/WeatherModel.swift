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
    let storageService: CoreDataWeather
    
    init(delegate: WeatherModelDelegate? = nil) {
        self.delegate = delegate
        self.networkService = ServiceProvider.networkService()
        self.storageService = ServiceProvider.coreDataService()
    }
}

// MARK: - WeatherModelProtocol
extension WeatherModel: WeatherModelProtocol {
    
    func loadData(for city: String) {

        //debugPrint("loadData for - \(city)")
        
        networkService.loadWeatherForCity(city, with: parametrs) { [weak self] weatherInfo, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let data = weatherInfo  {
                
                let tempWeather = Weather(
                    city: data.name,
                    desc: data.weather[0].descWeather,
                    temp: data.main.temp
                )
                
                self?.delegate?.dataDidLoad(with: tempWeather)
            }
        }
    }
    
    func checkCity(with name: String) {
        self.delegate?.cityDidLoad(
            with: storageService.fetchCityWith(name)
        )
    }
    
    func addCity(with name: String) {
        self.storageService.insertCity(name)
    }
}
