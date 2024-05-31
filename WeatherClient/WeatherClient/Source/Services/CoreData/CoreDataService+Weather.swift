//
//  CoreDataService+Weather.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 13.05.2024.
//

import CoreData
import Foundation
import UIKit

protocol CoreDataWeather {
    func insertWeather(_ main: DMWeatherInfo, with forecast: DMWeatherInfoList?, for city: CityDataModel)
    func fetchWeatherFor(_ city: CityDataModel) -> CDWeatherMain?
    func deleteWeatherFor(_ city: CityDataModel)
    
    func fetchAllCDWeatherMain() -> [CDWeatherMain]
    func fetchAllCDWeatherForecast() -> [CDWeatherForecast]
    
    func deleteOldWeatherFor(_ city: CityDataModel)
    //func deleteWeatherFor(_ city: CityDataModel)
    func deleteAllWeatherData()
    func deleteAllOldWeatherData()
}

// MARK: - CoreDataWeather
extension CoreDataService: CoreDataWeather {
    
    func deleteAllOldWeatherData() {
        
        let fetchRequest = CDWeatherMain.fetchRequest()
        
        let minDt = getMinTimeMarkForStore()
        
        fetchRequest.predicate = NSPredicate(
            format: "timeMark < %d", minDt
        )
        
        deleteRecords(CDWeatherMain.self, fetchRequest: fetchRequest)
        
        deleteAllOldWeatherForecastData()
    }
    
    func deleteAllOldWeatherForecastData() {
        
        let fetchRequest = CDWeatherForecast.fetchRequest()
        
        let minDt = getMinTimeMarkForStore()
        
        fetchRequest.predicate = NSPredicate(
            format: "timeMark < %d", minDt
        )
        
        deleteRecords(CDWeatherForecast.self, fetchRequest: fetchRequest)
    }
    
    func deleteAllWeatherData() {
        
        let fetchRequest = CDWeatherMain.fetchRequest()
        deleteRecords(CDWeatherMain.self, fetchRequest: fetchRequest)
        
        deleteAllWeatherForecastData()
    }
    
    func deleteAllWeatherForecastData() {
        
        let fetchRequest = CDWeatherForecast.fetchRequest()
        deleteRecords(CDWeatherForecast.self, fetchRequest: fetchRequest)
    }
    
    func fetchAllCDWeatherMain() -> [CDWeatherMain] {
        
        let fetchRequest = CDWeatherMain.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeMark", ascending: true)]
        
        let fetchedResult = fetchDataFromEntity(CDWeatherMain.self, fetchRequest: fetchRequest)
        
        return fetchedResult
    }
    
    func fetchAllCDWeatherForecast() -> [CDWeatherForecast] {
        
        let fetchRequest = CDWeatherForecast.fetchRequest()
        
        //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeMark", ascending: true)]
        
        let fetchedResult = fetchDataFromEntity(CDWeatherForecast.self, fetchRequest: fetchRequest)
        
        return fetchedResult
    }
    
    func insertWeather(_ main: DMWeatherInfo, with forecast: DMWeatherInfoList?, for city: CityDataModel) {
        
        
        let weatherMainEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherMain", in: context)!
        
        guard let weatherMainEntity = NSManagedObject(entity: weatherMainEntityDescription, insertInto: context) as? CDWeatherMain
        else {
            assertionFailure()
            return
        }
        
        weatherMainEntity.timeMark = Int32(Date().timeIntervalSince1970)
        
        //weatherMainEntity.city = fetchCityWith(city)
        weatherMainEntity.latitude = city.latitude
        weatherMainEntity.longitude = city.longitude
        
        weatherMainEntity.timezone = Int32(main.timezone)
        
        weatherMainEntity.temp = main.main.temp
        weatherMainEntity.descriptMain = main.weather[0].main
        
        if let detailsEntity = insertWetherCurrent(with: main) {
            detailsEntity.relationship = weatherMainEntity
            detailsEntity.timeMark = weatherMainEntity.timeMark
        }
        
        if let fc = forecast {
            for details in fc.list {
                if let detailsEntity = insertWetherDeatils(with: details) {
                    detailsEntity.relationship = weatherMainEntity
                    detailsEntity.timeMark = weatherMainEntity.timeMark
                }
            }
        }
        
        save(context: context)
    }
    
    func insertWetherCurrent(with details: DMWeatherInfo) -> CDWeatherForecast? {
        
        let weatherDetailsEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherForecast", in: context)!
        guard let weatherDetailsEntity = NSManagedObject(entity: weatherDetailsEntityDescription, insertInto: context) as? CDWeatherForecast
        else {
            assertionFailure()
            return nil
        }
        
        weatherDetailsEntity.dt = Int32(details.dt)
        
        weatherDetailsEntity.temp = details.main.temp
        
        weatherDetailsEntity.descriptMain = details.weather.first?.main
        weatherDetailsEntity.descriptDetail = details.weather.first?.descWeather
        weatherDetailsEntity.descriptIcon = details.weather.first?.icon
        
        weatherDetailsEntity.pressure = details.main.pressure
        weatherDetailsEntity.humidity = details.main.humidity
        weatherDetailsEntity.feelsLike = details.main.feelsLike
        
        weatherDetailsEntity.windSpeed = details.wind.speed
        weatherDetailsEntity.windDeg = details.wind.deg
        weatherDetailsEntity.windGust = details.wind.gust
        
        weatherDetailsEntity.sunrise = Int32(details.sys.sunset)
        weatherDetailsEntity.sunset = Int32(details.sys.sunset)
        
        weatherDetailsEntity.visibility = details.visibility ?? 0.0
        
        return weatherDetailsEntity
    }
    
    func insertWetherDeatils(with details: DMWeatherInfoList.List) -> CDWeatherForecast? {
        
        let weatherDetailsEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherForecast", in: context)!
        guard let weatherDetailsEntity = NSManagedObject(entity: weatherDetailsEntityDescription, insertInto: context) as? CDWeatherForecast
        else {
            assertionFailure()
            return nil
        }
        
        weatherDetailsEntity.dt = Int32(details.dt)
        weatherDetailsEntity.temp = details.main.temp
        weatherDetailsEntity.descriptMain = details.weather[0].main
        
        weatherDetailsEntity.descriptIcon = details.weather.first?.icon
        
        return weatherDetailsEntity
    }
    
    func fetchWeatherFor(_ city: CityDataModel) -> CDWeatherMain? {
        
        //let city = fetchCityWith(city)
        
        //fetch
        let fetchRequest = CDWeatherMain.fetchRequest()
        
        fetchRequest.fetchLimit = 1
        
        let maxDt = getMaxTimeMarkBeforeUpdate()
        
//        fetchRequest.predicate = NSPredicate(
//            format: "city == %@", city!
//        )
        
//        let cityPredicate = NSPredicate(
//            format: "city == %@", city.name
//        )
        
        let latitudePredicate = NSPredicate(
            format: "latitude == %f", city.latitude
        )
        
        let longitudePredicate = NSPredicate(
            format: "longitude == %f", city.longitude
        )

        let timePredicate = NSPredicate(
            format: "timeMark > %d", maxDt
        )

        fetchRequest.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                latitudePredicate,
                longitudePredicate,
                timePredicate
            ]
        )
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeMark", ascending: true)]
        
        let fetchedResult = fetchDataFromEntity(CDWeatherMain.self, fetchRequest: fetchRequest).first
        
        return fetchedResult
    }

    func deleteOldWeatherFor(_ city: CityDataModel) {
        
        //DispatchQueue.global(qos: .default).async { [self] in
            
            let city = fetchCityWith(city)
            
            let fetchRequest = CDWeatherMain.fetchRequest()
            
            let minDt = getMinTimeMarkForStore()
            
            debugPrint("\(minDt)")
            
            let cityPredicate = NSPredicate(
                format: "city == %@", city!
            )

            let timePredicate = NSPredicate(
                format: "timeMark < %d", minDt
            )

            fetchRequest.predicate = NSCompoundPredicate(
                andPredicateWithSubpredicates: [
                    cityPredicate,
                    timePredicate
                ]
            )
            
            let fetchedResult = fetchDataFromEntity(CDWeatherMain.self, fetchRequest: fetchRequest)
            debugPrint("\(fetchedResult.count)")
            
            deleteRecords(CDWeatherMain.self, fetchRequest: fetchRequest)
        //}
    }
    
    func deleteWeatherFor(_ city: CityDataModel) {
        
        let city = fetchCityWith(city)
        
        let fetchRequest = CDWeatherMain.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "city == %@", city!
        )
        
        deleteRecords(CDWeatherMain.self, fetchRequest: fetchRequest)
    }
    
    func getMaxTimeMarkBeforeUpdate() -> Int32 {
        
        let timeInterval = Int32(Date().timeIntervalSince1970)
        
        let maxTimeMarkBeforeUpdate = timeInterval - Constant.updateDelay
        
        return maxTimeMarkBeforeUpdate
    }
    
    func getMinTimeMarkForStore() -> Int32 {
        
        let timeInterval = Int32(Date().timeIntervalSince1970)
        
        let minTimeMarkForStore = timeInterval - Constant.storagePeriod
        
        return minTimeMarkForStore
    }
}
