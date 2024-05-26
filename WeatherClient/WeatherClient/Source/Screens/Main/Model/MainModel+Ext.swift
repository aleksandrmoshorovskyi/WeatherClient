//
//  MainModel+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 26.05.2024.
//

import Foundation

// MARK: - MainModelProtocol
extension MainModel: MainModelProtocol {
    
    func loadData() {
        
        var cities: [WeatherViewController] = []
        
        let sortedCities = storageService.fetchAllCities()
        
        //sorted
        
        if sortedCities.count > 0 {
            sortedCities.forEach() { 
                //debugPrint("\($0.cityName ?? "")")
                
                let VC = WeatherViewController()
                //VC.dataSource = $0.cityName ?? ""
                //VC.doSomething(with: $0.cityName ?? "")
                
                VC.loadWeatherData(for: $0)
                
                cities.append(VC)
            }
            
            self.delegate?.dataDidLoad(with: cities)
            
        } else {
            debugPrint("no data (cities)")
            //to add VC
            self.delegate?.dataDidLoad(with: [])
        }
    }
}
