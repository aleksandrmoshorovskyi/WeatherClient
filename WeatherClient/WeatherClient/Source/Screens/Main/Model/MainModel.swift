//
//  MainModel.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import Foundation

class MainModel {
    
    //only for test {
    let city = "Dnipro"
    let location = Location(latitude: 49.989619, longitude: 36.241182)
    let parametrs = (units: Units.metric, lang: Lang.ua)
    var value: String = "" //Variable 'self' was written to, but never read
    
    var cities: [WeatherViewController] = []
    // }
    
    weak var delegate: MainModelDelegate?
    
    let networkService: NetworkServiceWeather
    let storageService: CoreDataWeather
    
    init(delegate: MainModelDelegate? = nil) {
        self.delegate = delegate
        self.networkService = ServiceProvider.networkService()
        self.storageService = ServiceProvider.coreDataService()
    }
}

// MARK: - MainModelProtocol
extension MainModel: MainModelProtocol {
    
    func loadData() {
        
        var cities: [WeatherViewController] = []
        
        let storedCities = storageService.fetchAllCities()
        
        if storedCities.count > 0 {
            storedCities.forEach() {
                //debugPrint("\($0.cityName ?? "")")
                
                let VC = WeatherViewController()
                //VC.dataSource = $0.cityName ?? ""
                VC.doSomething(with: $0.cityName ?? "")
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
