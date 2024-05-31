//
//  SettingsModel+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

extension SettingsModel: SettingsModelProtocol {
    
    func swapCities(_ sourceCity: CityDataModel, _ destinationCity: CityDataModel) {
        storageService.swapCities(sourceCity, destinationCity)
    }
    
    func deleteCity(for item: CityDataModel) {
        storageService.deleteCity(item)
    }

    func loadData() {
        
        //cities = []
        var citiesWithWeather: [CityWeatherDataModel] = []
        
        let storedCities = storageService.fetchAllCDCities()
        
        if storedCities.count > 0 {
            storedCities.forEach() {

                //let city = CityWeatherModel(order: 0, name: $0.cityName ?? "")
                let city = CityDataModel(
                    name: $0.cityName ?? "",
                    latitude: $0.cityLatitude,
                    longitude: $0.cityLongitude,
                    state: $0.cityState,
                    country: $0.cityCountry,
                    order: Int($0.cityOrder)
                )
                let cityWithWeather = CityWeatherDataModel(city: city)
                
                citiesWithWeather.append(cityWithWeather)
            }
            
            self.delegate?.citiesDidLoad(with: citiesWithWeather)
            loadWeatherForCities(citiesWithWeather)
            
        } else {
            //debugPrint("no data (cities)")
            //no data
        }
    }
    
    func loadWeatherForCities(_ cities: [CityWeatherDataModel]) {
        
        var citiesWithWeather = cities
        
        citiesWithWeather.enumerated().forEach() {index, value in
            networkService.loadWeatherForCity(value.city.name, with: parametrs) { [weak self] weatherInfo, error in

                if let err = error {
                    debugPrint("\(err.localizedDescription)")
                }

                if let data = weatherInfo  {
                    //debugPrint("\(data.name)")

//                    let tempWeather = WeatherDataModel(
//                        city: data.name,
//                        desc: data.weather[0].descWeather,
//                        temp: data.main.temp,
//                        pressure: 0.0,
//                        humidity: 0.0
//                    )
                    
                    let tempWeather = WeatherCompactDataModel(
                        city: data.name,
                        desc: data.weather[0].descWeather,
                        temp: data.main.temp
                    )
                    
                    citiesWithWeather[index].weather = tempWeather
                    self?.delegate?.dataDidLoad(with: citiesWithWeather)
                }
            }
        }
    }
    
    func loadSearchData(for string: String) {

        //debugPrint("loadData for - \(city)")
        
        //networkService.loadWeatherForCity(city, with: parametrs) { [weak self] weatherInfo, error in
            networkService.loadWeatherLocation(for: string) { [weak self] weatherInfo, error in

            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }

            if let data = weatherInfo  {
                
//                let tempWeather = Weather(
//                    city: data.
//                    desc: data.weather[0].descWeather,
//                    temp: data.main.temp
//                )
                
                let searchData =  data.compactMap() {
                    //SearchDataModel(name: $0.name, state: $0.state, country: $0.country)
                    SearchDataModel(
                        name: $0.name,
                        latitude: $0.lat,
                        longitude: $0.lon,
                        state: $0.state,
                        country: $0.country
                    )
                }
                
                self?.delegate?.searchDataDidLoad(with: searchData)
            }
        }
    }
}
