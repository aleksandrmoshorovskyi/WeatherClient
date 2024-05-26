//
//  CoreDataService+Weather.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 13.05.2024.
//

import CoreData

protocol CoreDataWeather {
    
    //func insertCity(_ city: String)
    func insertCity(_ city: CityDataModel)
    
    func fetchAllCDCities() -> [CDWeatherCities]
    func fetchAllCities() -> [CityDataModel]
    
    //func fetchCityWith(_ name: String) -> CDWeatherCities?
    func fetchCityWith(_: CityDataModel) -> CDWeatherCities?
    
    
    //func deleteCityWith(_ name: String)
    
    func deleteCity(_ city: CityDataModel)
    //func changeCity(_ city: CityDataModel)
    
    func swapCities(_ sourceCity: CityDataModel, _ destinationCity: CityDataModel)
}

// MARK: - CoreDataWeather
extension CoreDataService: CoreDataWeather {
        
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
    
//    func deleteCityWith(_ name: String) {
//        
//        let fetchRequest = CDWeatherCities.fetchRequest()
//        fetchRequest.predicate = NSPredicate(
//            format: "cityName == %@", name
//        )
//        
//        deleteRecords(CDWeatherCities.self, fetchRequest: fetchRequest)
//    }
    
    func deleteCity(_ city: CityDataModel) {
        
        let fetchRequest = CDWeatherCities.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "cityName == %@", city.name
        )
        
        deleteRecords(CDWeatherCities.self, fetchRequest: fetchRequest)
    }
    
//    func changeCityWith(_ name: String) {
//        
//        let fetchRequest = CDWeatherCities.fetchRequest()
//        fetchRequest.predicate = NSPredicate(
//            format: "cityName == %@", name
//        )
//        
//        let fetchedResult = fetchDataFromEntity(CDWeatherCities.self, fetchRequest: fetchRequest).first
//        
//        if let fetchedData = fetchedResult {
//            fetchedData.cityOrder = 0
//            //fetchedData.id
//            save(context: context)
//        }
//    }
    
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
//        do {
//            try <#throwing expression#>
//        } catch <#pattern#> {
//            <#statements#>
//        }
        
        changeCityOrderFor(sourceCity, order: destinationCity.order ?? 0)
        changeCityOrderFor(destinationCity, order: sourceCity.order ?? 0)
    }
    
    /*
     let weatherCitiesEntityDescription = NSEntityDescription.entity(forEntityName: "CDWeatherCities", in: context)!
     
     guard let weatherCityEntity = NSManagedObject(entity: weatherCitiesEntityDescription, insertInto: context) as? CDWeatherCities
     else {
         assertionFailure()
         return
     }
     
     weatherCityEntity.cityName = city
     
     save(context: context)
     */
}

/*
 
 You can do this, works for me.

 if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{

         let context = container.viewContext

         let fetchRequest = NSFetchRequest<Account>(entityName: "Account")

         let name = self.txtAccount.text

         fetchRequest.predicate = NSPredicate(format: "name == %@", name!)

         do {

             let results = try context.fetch(fetchRequest)

             if (results.count > 0){

                 for result in results{

                     id = result.id
                     number = result.number

                 }

                 actualNumber = (number + 1)

                 //Update the account balance
                 let update = results[0]
                 update.number = actualNumber

                 try context.save()

                 return id

             }

         }catch let error {

             print("Error....: \(error)")

         }
 */

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
