//
//  WeatherModel+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 29.05.2024.
//

import Foundation

// MARK: - WeatherModelProtocol
extension WeatherModel: WeatherModelProtocol {
    
    func loadData(for city: CityDataModel) {
        
        let allCities = storageService.fetchAllCDCities()
        let weatherMain = storageService.fetchAllCDWeatherMain()
        let weatherForecast = storageService.fetchAllCDWeatherForecast()
        
        debugPrint("\(allCities.count) \(weatherMain.count) \(weatherForecast.count)")
        
        if let storedData = storageService.fetchWeatherFor(city) {
            
//            let forecastSet = storedData.forecast
//            let sortDesc = [NSSortDescriptor(key: "dt", ascending: true)]
//            let sortedArray = forecastSet?.sortedArray(using: sortDesc) as! [CDWeatherForecast]
//            
//            let curWeath = sortedArray.first
//            
//            if let curWeath = sortedArray.first {
//                delegate?.dataDidLoad(with: getDataModelFrom(curWeath, for: city))
//            }
            
            //PrepareAndSubmitData(storedData, for: city)
            delegate?.dataDidLoad(with: getDataModelFrom(storedData, for: city))
            
        } else {
            
            networkService.loadWeatherForCity(city.name, with: parametrs) { [weak self] weatherInfo, error in

                if let err = error {
                    debugPrint("\(err.localizedDescription)")
                }

                if let data = weatherInfo  {
                    
                    if let self = self {
                        
                        let location = Location(latitude: Double(city.latitude), longitude: Double(city.longitude))
                        
                        networkService.loadWeatherForecastForLocation(location, with: parametrs) { [weak self] weatherInfoList, error in
                            
                            if let err = error {
                                debugPrint("\(err.localizedDescription)")
                            }
                            
                            if let dataList = weatherInfoList {
                                self?.storageService.insertWeather(data, with: dataList, for: city)
                                
                                if let fetchedWeather = self?.storageService.fetchWeatherFor(city) {
                                    if let self = self {
                                        //PrepareAndSubmitData(fetchedWeather, for: city)
                                        delegate?.dataDidLoad(with: getDataModelFrom(fetchedWeather, for: city))
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    //self?.storageService.insertWeather(data, with: nil, for: city)
                    
                    //if let fetchedWeather = self?.storageService.fetchWeatherFor(city) {
                        
//                        let forecastSet = fetchedWeather.forecast
//                        let sortDesc = [NSSortDescriptor(key: "dt", ascending: true)]
//                        let sortedArray = forecastSet?.sortedArray(using: sortDesc) as! [CDWeatherForecast]
//                        
//                        if let self = self {
//                            if let curWeath = sortedArray.first {
//                                self.delegate?.dataDidLoad(with: self.getDataModelFrom(curWeath, for: city))
//                            }
//                        }

//                        if let self = self {
//                            PrepareAndSubmitData(fetchedWeather, for: city)
//                        }
                        
                        
                    //}
                    
                }
            }
        }
        
        //storageService.deleteOldWeatherFor(city)
        //storageService.deleteAllWeatherFor(city)
        //storageService.deleteAllWeatherData()
        storageService.deleteAllOldWeatherData()
    }
    
    func checkCity(_ city: CityDataModel) {
        self.delegate?.cityDidLoad(
            with: storageService.fetchCityWith(city)
        )
    }
    
    func addCity(_ city: CityDataModel) {
        self.storageService.insertCity(city)
    }
    
//    func getDataModelFrom(_ networkData: CDWeatherForecast, for city: CityDataModel) -> WeatherDataModel {
//        
//        return WeatherDataModel(
//            city: city.name,
//            desc: networkData.descriptDetail ?? "",
//            temp: networkData.temp,
//            pressure: networkData.pressure,
//            humidity: networkData.humidity, 
//            feelsLike: networkData.feelsLike, 
//            wind: Wind(speed: networkData.windSpeed, deg: networkData.windDeg, gust: networkData.windGust), 
//            sys: Sys(sunrise: Int(networkData.sunrise), sunset: Int(networkData.sunset)), 
//            visibility: networkData.visibility
//        )
//    }
    
    func getDateFromTimeInterval(_ timeInterval: TimeInterval, for timezone: Int) {
        
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let components = date.get(.day, .month, .year)
        
        if let day = components.day, let month = components.month, let year = components.year {
            print("day: \(day), month: \(month), year: \(year)")
        }
        
        let hour = date.get(.hour)
        
        debugPrint("\(hour)")
    }
    
    func getDayFrom(_ dt: Int, for timezone: Int) -> Date {
        
        let timeInterval = TimeInterval(dt + timezone)
        
        guard let date = Date(timeIntervalSince1970: timeInterval).onlyDate
        else {
            return Date.now
        }
        
        return date
    }
    
    func getDataModelFrom(_ storedData: CDWeatherMain, for city: CityDataModel) -> WeatherDataModel? {
        
        let currentTimezone = storedData.timezone
        var weatherDataModel: WeatherDataModel? = nil
        
        let forecastSet = storedData.forecast
        let sortDesc = [NSSortDescriptor(key: "dt", ascending: true)]
        let sortedArray = forecastSet?.sortedArray(using: sortDesc) as! [CDWeatherForecast]
        
        if let networkData = sortedArray.first {
            
            //hourly forecast {
            var isFirstHour = true
            var hourlyArray: [HourlyForecast] = []
            let currentDt = networkData.dt //+ currentTimezone
            let dayAfterDt = currentDt + Constant.periodDay
            
            for item in sortedArray {
                if item.dt >= currentDt && item.dt < dayAfterDt {
                    
                    var timeStr = ""
                    
                    if isFirstHour {
                        timeStr = "Now"
                    } else {
                        timeStr = "\(Date(timeIntervalSince1970: TimeInterval(item.dt)).get(.hour))"
                    }
                    
                    let hf = HourlyForecast(
                        dt: Int(item.dt),
                        time: timeStr,
                        icon: item.descriptIcon ?? "",
                        desc: Temp.stringTemp(item.temp)
                    )
                    
                    hourlyArray.append(hf)
                    isFirstHour = false
                }
                
            }
            
            hourlyArray.sort() { $0.dt < $1.dt }
            //} hourly forecast
            
            //dayli forecast {
            var isFirstDay = true
            var dayliArray: [DayliForecast] = []
            //let currentDt = networkData.dt //+ currentTimezone
            //let dayAfterDt = currentDt + Constant.periodDay
            
            for item in sortedArray {
                //if item.dt >= currentDt && item.dt < dayAfterDt {
                    
                    var dayStr = ""
                    
                    if isFirstDay {
                        dayStr = "Today"
                    } else {
                        dayStr = "\(Date(timeIntervalSince1970: TimeInterval(item.dt)).get(.hour))"
                    }
                
                    let df = DayliForecast(
                        dt: Int(item.dt),
                        day: dayStr,
                        icon: item.descriptIcon ?? "",
                        tempMin: Temp.stringTemp(item.temp),
                        tempMax: Temp.stringTemp(item.temp)
                    )
                    
                dayliArray.append(df)
                    isFirstDay = false
                //}
                
            }
            
            dayliArray.sort() { $0.dt < $1.dt }
            //} dayli forecast
            
            weatherDataModel = WeatherDataModel(
                city: city.name,
                desc: networkData.descriptDetail ?? "",
                temp: networkData.temp,
                tempMin: networkData.temp,
                tempMax: networkData.temp,
                pressure: networkData.pressure,
                humidity: networkData.humidity,
                feelsLike: networkData.feelsLike,
                wind: Wind(speed: networkData.windSpeed, deg: networkData.windDeg, gust: networkData.windGust),
                sys: Sys(sunrise: Int(networkData.sunrise), sunset: Int(networkData.sunset)),
                visibility: networkData.visibility
            )
            
            weatherDataModel?.hourlyForecast = hourlyArray
            weatherDataModel?.dayliForecast = dayliArray
        }
        
        return weatherDataModel
    }
    
    func PrepareAndSubmitData(_ storedData: CDWeatherMain, for city: CityDataModel) {
        
        //let forecastSet = storedData.forecast
        //let sortDesc = [NSSortDescriptor(key: "dt", ascending: true)]
        //let sortedArray = forecastSet?.sortedArray(using: sortDesc) as! [CDWeatherForecast]
        
        //let curWeath = sortedArray.first
        
        //if let curWeath = sortedArray.first {
            //delegate?.dataDidLoad(with: getDataModelFrom(curWeath, for: city))
            delegate?.dataDidLoad(with: getDataModelFrom(storedData, for: city))
        //}
    }
}
