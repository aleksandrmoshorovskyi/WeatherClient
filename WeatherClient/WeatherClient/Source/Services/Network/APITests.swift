//
//  APITests.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 09.05.2024.
//

import Foundation

class APITests {
    
    let networkService = ServiceProvider.networkService()
    
    let city = "Dnipro"
    let location = Location(latitude: 49.989619, longitude: 36.241182)
    let parametrs = (units: Units.metric, lang: Lang.ua)
    
    var value: String = "" //Variable 'self' was written to, but never read
    
    
    // MARK: - GEOCODERS
    func testloadCityForLocation() {
    
        networkService.loadWeatherCity(for: location) { [weak self] geoInfo, error in
                        
            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }
            
            if let geo = geoInfo {
                debugPrint("\(geo[0].name)")
                self?.value = "\(geo[0].name)"
                //self?.mainLabel.text = "\(geo[0].name)"
            }
        }
    }
       
    func testloadLocationForCity() {
        
        networkService.loadWeatherLocation(for: city) { [weak self] geoInfo, error in
                        
            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }
            
            if let geo = geoInfo {
                debugPrint("\(geo[0].name)")
                self?.value = "\(geo[0].name)"
                //self?.mainLabel.text = "\(geo[0].name)"
            }
        }
    }
    
    
    // MARK: - CURRENT
    func testLoadCurrentWeatherForLocation() {
    
        networkService.loadWeatherForLocation(location) { [weak self] weatherInfo, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let weather = weatherInfo  {
                //debugPrint("\(weather.)")
                self?.value = "\(weather.name)"
                //self?.mainLabel.text = "\(weather.name)"
            }
        }
    }
    
    func testLoadCurrentWeatherForLocationWithParams() {
    
        networkService.loadWeatherForLocation(location, with: parametrs) { [weak self] weatherInfo, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let weather = weatherInfo  {
                //debugPrint("\(weather.)")
                self?.value = "\(weather.name)"
                //self?.mainLabel.text = "\(weather.name)"
            }
        }
    }

    func testLoadCurrentWeatherForCity() {
     
        networkService.loadWeatherForCity(city) { [weak self] weatherInfo, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let weather = weatherInfo  {
                //debugPrint("\(weather.)")
                self?.value = "\(weather.name)"
                //self?.mainLabel.text = "\(weather.name)"
            }
        }
    }
    
    func testLoadCurrentWeatherForCityWithParams() {
     
        networkService.loadWeatherForCity(city, with: parametrs) { [weak self] weatherInfo, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let weather = weatherInfo  {
                //debugPrint("\(weather.)")
                self?.value = "\(weather.name)"
                //self?.mainLabel.text = "\(weather.name)"
            }
        }
    }
    
    
    // MARK: - FORECAST
    func testLoadForecastForLocation() {
        
        networkService.loadWeatherForecastForLocation(location) { [weak self] weatherInfoList, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let weather = weatherInfoList  {
                //debugPrint("\(weather.)")
                self?.value = "\(weather.city)"
                //self?.mainLabel.text = "\(weather.list)"
            }
        }
    }
    
    func testLoadForecastForLocationWithParams() {
        
        networkService.loadWeatherForecastForLocation(location, with: parametrs) { [weak self] weatherInfoList, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let weather = weatherInfoList  {
                //debugPrint("\(weather.)")
                self?.value = "\(weather.city)"
                //self?.mainLabel.text = "\(weather.list)"
            }
        }
    }

    func testLoadForecastForCity() {
        
        networkService.loadWeatherForecastForCity(city) { [weak self] weatherInfoList, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let weather = weatherInfoList  {
                //debugPrint("\(weather.)")
                self?.value = "\(weather.city)"
                //self?.mainLabel.text = "\(weather.list)"
            }
        }
    }
    
    func testLoadForecastForCityWithParams() {
        
        networkService.loadWeatherForecastForCity(city, with: parametrs) { [weak self] weatherInfoList, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let weather = weatherInfoList  {
                //debugPrint("\(weather.)")
                self?.value = "\(weather.city)"
                //self?.mainLabel.text = "\(weather.list)"
            }
        }
    }
}
