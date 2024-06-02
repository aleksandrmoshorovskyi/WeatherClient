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
            
            let location = Location(latitude: Double(city.latitude), longitude: Double(city.longitude))
            
            //networkService.loadWeatherForCity(city.name, with: parametrs) { [weak self] weatherInfo, error in
            //networkService.loadWeatherForCity(city.name) { [weak self] weatherInfo, error in
            networkService.loadWeatherForLocation(location) { [weak self] weatherInfo, error in

                if let err = error {
                    debugPrint("\(err.localizedDescription)")
                }

                if let data = weatherInfo  {
                    
                    if let self = self {
                        
                        let location = Location(latitude: Double(city.latitude), longitude: Double(city.longitude))
                        
                        //networkService.loadWeatherForecastForLocation(location, with: parametrs) { [weak self] weatherInfoList, error in
                        networkService.loadWeatherForecastForLocation(location) { [weak self] weatherInfoList, error in
                            
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
        
        let _ = storedData.timezone //currentTimezone
        var weatherDataModel: WeatherDataModel? = nil
        
        //for Main
        var currentTempMin: Float = 0.0
        var currentTempMax: Float = 0.0
        
        let forecastSet = storedData.forecast
        let sortDesc = [NSSortDescriptor(key: "dt", ascending: true)]
        let sortedArray = forecastSet?.sortedArray(using: sortDesc) as! [CDWeatherForecast]
        
        if let networkData = sortedArray.first {
            
            //hourly forecast {
            var isFirstHour = true
            var hourlyArray: [HourlyForecast] = []
            let currentDt = networkData.dt //+ currentTimezone
            let dayAfterDt = currentDt + Constant.periodDay
            
            //for Main
            currentTempMin = networkData.tempMin
            currentTempMax = networkData.tempMax
            
            // tomorrow sunrise - sunset
            /*
             it will be with an error of a few minutes,
             because this is today's data,
             tomorrow's data is not available on the server
             */
            let tomorrowSunrise = networkData.sunrise + Constant.periodDay
            let tomorrowSunset = networkData.sunset + Constant.periodDay
            
            for item in sortedArray {
                if item.dt >= currentDt && item.dt < dayAfterDt {
                    
                    if item.tempMin < currentTempMin {
                        currentTempMin = item.tempMin
                    }
                    
                    if item.tempMax > currentTempMax {
                        currentTempMax = item.tempMax
                    }
                    
                    //debugPrint("\(item.sunrise)")
                    /*
                    if item.sunrise > tomorrowSunrise {
                        tomorrowSunrise = item.sunrise
                    }
                    
                    if item.sunset > tomorrowSunset {
                        tomorrowSunset = item.sunset
                    }
                     */
                    
                    var timeStr = ""
                    
                    if isFirstHour {
                        timeStr = "Now"
                    } else {
                        //timeStr = "\(Date(timeIntervalSince1970: TimeInterval(item.dt)).get(.hour))"
                        timeStr = DateStr.timeFromDateInterval(Int(item.dt), like: "HH")
                    }
                    
                    let hf = HourlyForecast(
                        dt: Int(item.dt),
                        time: timeStr,
                        icon: item.descriptIcon ?? "",
                        desc: Metrics.strTemp(item.temp)
                    )
                    
                    hourlyArray.append(hf)
                    isFirstHour = false
                }
                
            }
            
            //item Sunrise (today)
            if networkData.sunrise > currentDt {
                let hfSunrise = HourlyForecast(
                    dt: Int(networkData.sunrise),
                    time: DateStr.timeFromDateInterval(Int(networkData.sunrise), like: "HH:mm"),
                    icon: "sunrise",
                    desc: "Sunrise"
                )
                hourlyArray.append(hfSunrise)
            }
            
            //item Sunset (today)
            if networkData.sunset > currentDt {
                let hfSunset = HourlyForecast(
                    dt: Int(networkData.sunset),
                    time: DateStr.timeFromDateInterval(Int(networkData.sunset), like: "HH:mm"),
                    icon: "sunset",
                    desc: "Sunset"
                )
                hourlyArray.append(hfSunset)
            }

            //item Sunrise (tomorrow)
            if tomorrowSunrise > currentDt {
                let hfSunrise = HourlyForecast(
                    dt: Int(tomorrowSunrise),
                    time: DateStr.timeFromDateInterval(Int(tomorrowSunrise), like: "HH:mm"),
                    icon: "sunrise",
                    desc: "Sunrise"
                )
                hourlyArray.append(hfSunrise)
            }
            
            //item Sunset (tomorrow)
            if tomorrowSunset < dayAfterDt {
                let hfSunset = HourlyForecast(
                    dt: Int(tomorrowSunset),
                    time: DateStr.timeFromDateInterval(Int(tomorrowSunset), like: "HH:mm"),
                    icon: "sunset",
                    desc: "Sunset"
                )
                hourlyArray.append(hfSunset)
            }
            
            hourlyArray.sort() { $0.dt < $1.dt }
            //} hourly forecast
            
            //dayli forecast {
            var isFirstDay = true
            var dayliArray: [DayliForecast] = []
            //let currentDt = networkData.dt //+ currentTimezone
            //let dayAfterDt = currentDt + Constant.periodDay
            var currentDayEEE = DateStr.timeFromDateInterval(Int(networkData.dt), like: "EEE")
            var temporaryDayEEE = ""
            var temporaryHourHH = ""
            
            var tempDt = Int(networkData.dt)
            //var tempDay = currentDayEEE
            //var tempIcon = ""
            var tempIcon = networkData.descriptIcon ?? ""
            var temptempMin = currentTempMin
            var temptempMax = currentTempMax
            
            for item in sortedArray {
                temporaryDayEEE = DateStr.timeFromDateInterval(Int(item.dt), like: "EEE")
                temporaryHourHH = DateStr.timeFromDateInterval(Int(item.dt), like: "HH")
                
                //debugPrint("temporaryDayEEE - \(temporaryDayEEE)")
                //debugPrint("currentDayEEE - \(currentDayEEE)")
                
                if temporaryDayEEE == currentDayEEE {
                    tempDt = Int(item.dt)
                    //tempDay = temporaryDayEEE
                    //tempIcon = item.descriptIcon ?? ""
                    
                    if temporaryHourHH == "12" {
                        tempIcon = item.descriptIcon ?? ""
                    }
                    
                    temptempMin = item.tempMin < temptempMin ? item.tempMin : temptempMin
                    temptempMax = item.tempMax > temptempMax ? item.tempMax : temptempMax
                } else {
                    var dayStr = ""
                    
                    if isFirstDay {
                        dayStr = "Today"
                    } else {
                        //dayStr = "\(Date(timeIntervalSince1970: TimeInterval(item.dt)).get(.hour))"
                        dayStr = DateStr.timeFromDateInterval(Int(tempDt), like: "EEE")
                    }
                    
                    let df = DayliForecast(
                        dt: tempDt,
                        day: dayStr,
                        icon: tempIcon,
                        tempMin: Metrics.strTemp(temptempMin),
                        tempMax: Metrics.strTemp(temptempMax)
                    )
                    
                    dayliArray.append(df)
                    isFirstDay = false
                    
                    currentDayEEE = DateStr.timeFromDateInterval(Int(item.dt), like: "EEE")
                    
                    tempDt = 0
                    //tempDay = ""
                    tempIcon = ""
                    temptempMin = 1000
                    temptempMax = -1000
                }
            }
            
            /*
            for item in sortedArray {
                //if item.dt >= currentDt && item.dt < dayAfterDt {
                    
                    var dayStr = ""
                    
                    if isFirstDay {
                        dayStr = "Today"
                    } else {
                        //dayStr = "\(Date(timeIntervalSince1970: TimeInterval(item.dt)).get(.hour))"
                        dayStr = DateStr.timeFromDateInterval(Int(item.dt), like: "EEE")
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
             */
            
            dayliArray.sort() { $0.dt < $1.dt }
            //} dayli forecast
            
            weatherDataModel = WeatherDataModel(
                city: city.name,
                desc: networkData.descriptDetail ?? "",
                temp: networkData.temp,
                tempMin: currentTempMin,
                tempMax: currentTempMax,
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
