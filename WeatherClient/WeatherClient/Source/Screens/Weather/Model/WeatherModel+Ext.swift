//
//  WeatherModel+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 29.05.2024.
//

import Foundation

// MARK: - WeatherModelProtocol
extension WeatherModel: WeatherModelProtocol {
    
    func loadData(for city: CityDataModel) {
        
        let allCities = storageService.fetchAllCDCities()
        
        let weatherMain = storageService.fetchAllCDWeatherMain()
        
        let weatherForecast = storageService.fetchAllCDWeatherForecast()
        
        debugPrint("\(allCities.count) \(weatherMain.count) \(weatherForecast.count)")
        
        if let storedData = storageService.fetchWeatherFor(city) {
            
            delegate?.dataDidLoad(with: WeatherDataModel(
                city: city.name,
                desc: storedData.descriptMain ?? "",
                temp: storedData.temp)
            )
            
        } else {
            
            networkService.loadWeatherForCity(city.name, with: parametrs) { [weak self] weatherInfo, error in

                if let err = error {
                    debugPrint("\(err.localizedDescription)")
                }

                if let data = weatherInfo  {
                    
                    /*
                    let tempWeather = WeatherDataModel(
                        city: data.name,
                        desc: data.weather[0].descWeather,
                        temp: data.main.temp
                    )
                     */
                    
                    //self?.delegate?.dataDidLoad(with: tempWeather)
                    
                    self?.storageService.insertWeather(data, with: nil, for: city)
                    
                    if let fetchedWeather = self?.storageService.fetchWeatherFor(city) {
                        //self?.delegate?.dataDidLoad(with: fetchedWeather)
                        self?.delegate?.dataDidLoad(with: WeatherDataModel(
                            city: city.name,
                            desc: fetchedWeather.descriptMain ?? "",
                            temp: fetchedWeather.temp)
                        )
                    }
                    
                }
            }
        }
        
        //storageService.deleteOldWeatherFor(city)
        //storageService.deleteAllWeatherFor(city)
        //storageService.deleteAllWeatherData()
        storageService.deleteAllOldWeatherData()
    }
    
    /*
    func loadData(for city: CityDataModel) {
        
        networkService.loadWeatherForCity(city.name, with: parametrs) { [weak self] weatherInfo, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let data = weatherInfo  {
                
                let tempWeather = WeatherDataModel(
                    city: data.name,
                    desc: data.weather[0].descWeather,
                    temp: data.main.temp
                )
                
                self?.delegate?.dataDidLoad(with: tempWeather)
            }
        }
    }
     */
    
    func checkCity(_ city: CityDataModel) {
        self.delegate?.cityDidLoad(
            with: storageService.fetchCityWith(city)
        )
    }
    
    func addCity(_ city: CityDataModel) {
        self.storageService.insertCity(city)
    }
}


/*
 // MARK: - MainModelProtocol
 extension MainModel: MainModelProtocol {
     
     func loadData() {
         
         if let storedData = storageService.fetchAllWeatherInfo().last {
             
             delegate?.dataDidLoad(with: storedData)
             
         } else {
             
             DispatchQueue.global(qos: .default).async { [weak self] in
                 
                 let location = Location(latitude: 49.989619, longitude: 36.241182)
                 
                 self?.networkService.loadWrather(for: location) { [weak self] weatherInfo, error in
                     
                     DispatchQueue.main.async {
                         if let weather = weatherInfo {
                             
                             self?.storageService.insertWetherInfo(with: weather)
                             
                             if let fetchedWeather = self?.storageService.fetchAllWeatherInfo().last {
                                 self?.delegate?.dataDidLoad(with: fetchedWeather)
                             }
                         }
                     }
                 }
             }
         }
     }
 }
 */
