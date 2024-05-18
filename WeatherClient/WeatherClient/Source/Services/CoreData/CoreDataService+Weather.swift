//
//  CoreDataService+Weather.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 13.05.2024.
//

import CoreData

protocol CoreDataWeather {
    
    func insertCity(_ city: String)
    func fetchAllCities() -> [CDWeatherCities]
}

// MARK: - CoreDataWeather
extension CoreDataService: CoreDataWeather {
    
    func insertCity(_ city: String) {
        
        let weatherCitiesEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherCities", in: context)!
        
        guard let weatherCityEntity = NSManagedObject(entity: weatherCitiesEntityDescription, insertInto: context) as? CDWeatherCities
        else {
            assertionFailure()
            return
        }
        
        weatherCityEntity.cityName = city
        
        save(context: context)
    }
    
    func fetchAllCities() -> [CDWeatherCities] {
        
        let fetchRequest = CDWeatherCities.fetchRequest()
        let fetchedResult = fetchDataFromEntity(CDWeatherCities.self, fetchRequest: fetchRequest)
        
        return fetchedResult
    }
    
    func deleteAllCities() {
        
        deleteAll(CDWeatherCities.self)
    }
}

/*
protocol CoreDataWeather {
    
    func insertWetherInfo(with info: DMWeatherInfo)
    func fetchAllWeatherInfo() -> [CDWeatherInfo]
}

// MARK: - CoreDataWeather
extension CoreDataService: CoreDataWeather {
    
    func insertWetherInfo(with info: DMWeatherInfo) {
        
        let weatherInfoEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherInfo", in: context)!
        guard let weatherInfoEntity = NSManagedObject(entity: weatherInfoEntityDescription, insertInto: context) as? CDWeatherInfo
        else {
            assertionFailure()
            return
        }
        
        weatherInfoEntity.id = Int32(info.id)
        weatherInfoEntity.cityName = info.name
        weatherInfoEntity.temperature = info.main.temp
        weatherInfoEntity.pressure = Int32(info.main.pressure)
        weatherInfoEntity.humidity = Int32(info.main.humidity)
        
        for details in info.weather {
            if let detailsEntity = insertWetherDeatils(with: details) {
                detailsEntity.relationship = weatherInfoEntity
            }
        }
        
        save(context: context)
    }
    
    func fetchAllWeatherInfo() -> [CDWeatherInfo] {
        
        let fetchRequest = CDWeatherInfo.fetchRequest()
        let fetchedResult = fetchDataFromEntity(CDWeatherInfo.self, fetchRequest: fetchRequest)
        
        return fetchedResult
    }
}

// MARK: - WeatherDetails
private extension CoreDataService {
    
    func insertWetherDeatils(with details: DMWeatherInfo.Weather) -> CDWeatherDetails? {
        
        let weatherDetailsEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherDetails", in: context)!
        guard let weatherDetailsEntity = NSManagedObject(entity: weatherDetailsEntityDescription, insertInto: context) as? CDWeatherDetails
        else {
            assertionFailure()
            return nil
        }
        
        weatherDetailsEntity.id = Int32(details.id)
        weatherDetailsEntity.icon = details.icon
        weatherDetailsEntity.mainInfo = details.main
        weatherDetailsEntity.details = details.description
        
        return weatherDetailsEntity
    }
}
 */
