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
    
    var value: String = "" //Variable 'self' was written to, but never read
    
    func testloadCityForLocation() {
    
        networkService.loadCity(for: location) { [weak self] geoInfo, error in
                        
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
        
        networkService.loadCoord(for: city) { [weak self] geoInfo, error in
                        
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
    
    func testLoadCurrentWeatherForLocation() {
    
        networkService.loadCoordWrather(for: location) { [weak self] weatherInfo, error in

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
     
        networkService.loadCityWrather(for: city) { [weak self] weatherInfo, error in

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
    
    func testLoadForecastForLocation() {
        
        networkService.loadCoordWratherForecast(for: location) { [weak self] weatherInfoList, error in

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
        
        networkService.loadCityWratherForecast(for: city) { [weak self] weatherInfoList, error in

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
