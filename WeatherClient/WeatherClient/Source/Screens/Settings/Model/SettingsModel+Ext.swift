//
//  SettingsModel+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

extension SettingsModel: SettingsModelProtocol {
    
    func deleteCity(_ item: City) {
        storageService.deleteCityWith(item.name)
    }

    func loadData() {
        
        cities = []
        
        let storedCities = storageService.fetchAllCities()
        
        if storedCities.count > 0 {
            storedCities.forEach() {
                //debugPrint("\($0.cityName ?? "")")
                
                /*
                let city: citiesTuple = (
                    city: City(order: 0, name: $0.cityName ?? ""),
                    weather: nil
                )
                 */
                let city = City(order: 0, name: $0.cityName ?? "")
                
                cities.append(city)
            }
            
            self.delegate?.citiesDidLoad(with: cities)
            loadWeatherForCities(cities)
            
        } else {
            debugPrint("no data (cities)")
            //no data
        }
    }
    
    func loadWeatherForCities(_ cities: [City]) {
        
        var citiesWithWeather = cities
        
        citiesWithWeather.enumerated().forEach() {index, city in
            networkService.loadWeatherForCity(city.name, with: parametrs) { [weak self] weatherInfo, error in

                if let err = error {
                    debugPrint("\(err.localizedDescription)")
                }

                if let data = weatherInfo  {
                    //debugPrint("\(data.name)")

                    let tempWeather = Weather(
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
                    Search(name: $0.name, state: $0.state, country: $0.country)
                }
                
                self?.delegate?.searchDataDidLoad(with: searchData)
            }
        }
    }
}
