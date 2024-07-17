//
//  CoreDataService+City.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 29.05.2024.
//

import CoreData

protocol CoreDataCity {
    
    func insertCity(_ city: CityDataModel)
    
    func fetchAllCDCities() -> [CDWeatherCities]
    func fetchAllCities() -> [CityDataModel]
    func fetchCityWith(_: CityDataModel) -> CDWeatherCities?
    
    func deleteCity(_ city: CityDataModel)
    
    func swapCities(_ sourceCity: CityDataModel, _ destinationCity: CityDataModel)
}

// MARK: - CoreDataWeather
extension CoreDataService: CoreDataCity {
        
    func insertCity(_ city: CityDataModel) {
        
        let weatherCitiesEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherCities", in: context)!
        
        guard let weatherCityEntity = NSManagedObject(entity: weatherCitiesEntityDescription, insertInto: context) as? CDWeatherCities
        else {
            assertionFailure()
            return
        }
        
        weatherCityEntity.cityName = city.name
        //weatherCityEntity.cityOrder = Int16(city.order)
        weatherCityEntity.cityOrder = Int16(getOrder())
        weatherCityEntity.cityLatitude = city.latitude
        weatherCityEntity.cityLongitude = city.longitude
        //weatherCityEntity.cityState
        //weatherCityEntity.cityCountry
        
        save(context: context)
    }
    
    func fetchAllCDCities() -> [CDWeatherCities] {
        
        let fetchRequest = CDWeatherCities.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "cityOrder", ascending: true)]
        
        let fetchedResult = fetchDataFromEntity(CDWeatherCities.self, fetchRequest: fetchRequest)
        
        return fetchedResult
    }
    
    func fetchAllCities() -> [CityDataModel] {
        
        let CDData = fetchAllCDCities()
        
        return CDData.compactMap() {
            CityDataModel(
                name: $0.cityName ?? "",
                latitude: $0.cityLatitude,
                longitude: $0.cityLongitude,
                state: $0.cityState,
                country: $0.cityCountry,
                order: Int($0.cityOrder)
            )
        }
    }
    
    func getOrder() -> Int16 {
        
        let CDData = fetchAllCDCities()
        var maxOrder: Int16 = 0
        
        CDData.forEach() {
            if $0.cityOrder > maxOrder {
                maxOrder = $0.cityOrder
            }
        }
        
        return maxOrder + 1
    }
    
    func fetchCityWith(_ city: CityDataModel) -> CDWeatherCities? {

        let fetchRequest = CDWeatherCities.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "cityName == %@", city.name
        )
        
        let fetchedResult = fetchDataFromEntity(CDWeatherCities.self, fetchRequest: fetchRequest).first
        
        return fetchedResult
    }
    
    func deleteAllCities() {
        
        deleteAll(CDWeatherCities.self)
    }
    
    func deleteCity(_ city: CityDataModel) {
        
        let fetchRequest = CDWeatherCities.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "cityName == %@", city.name
        )
        
        deleteRecords(CDWeatherCities.self, fetchRequest: fetchRequest)
    }
    
    func changeCityOrderFor(_ city: CityDataModel, order: Int) {
        
        let fetchRequest = CDWeatherCities.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "cityName == %@", city.name
        )
        
        let fetchedResult = fetchDataFromEntity(CDWeatherCities.self, fetchRequest: fetchRequest).first
        
        if let fetchedData = fetchedResult {
            fetchedData.cityOrder = Int16(order)
            save(context: context)
        }
    }
    
    func swapCities(_ sourceCity: CityDataModel, _ destinationCity: CityDataModel) {
        
        //MARK: TO DO
        
//        do {
//            try <#throwing expression#>
//        } catch <#pattern#> {
//            <#statements#>
//        }
        
        changeCityOrderFor(sourceCity, order: destinationCity.order ?? 0)
        changeCityOrderFor(destinationCity, order: sourceCity.order ?? 0)
    }
}
