//
//  APIConstant.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import Foundation

struct APIConstant {
    
    static let baseUrl = "https://api.openweathermap.org"
    
    static let dataPath = "/data"
    static let geoPath = "/geo"
    
    static let apiVersion = "2.5"
    static let apiOldVersion = "1.0"
    
    static let weatherPath = "/weather"
    static let forecastPath = "/forecast"
    static let directPath = "/direct"
    static let reversePath = "/reverse"
    
    static let appId = "3ce97cc74d4cc39f3c06528e45532414"
    
    static func weatherUrl() -> String {
        return baseUrl + dataPath + "/" + apiVersion + weatherPath
    }
    
    static func forecastUrl() -> String {
        return ""//baseUrl + dataPath + "/" + apiVersion + weatherPath
    }
    
    static func geocoderUrl() -> String {
        return baseUrl + geoPath + "/" + apiOldVersion + directPath
    }
    
    static func reverseGeocoderUrl() -> String {
        return baseUrl + geoPath + "/" + apiOldVersion + reversePath
    }
}

/*
 //URL examples
 //current by coordinates
 https://api.openweathermap.org/data/2.5/weather?lat=48.4680221&lon=35.0417711&appid=3256cb7f2fb7edca2796fc3eab482a46&lang=ua
 
 //current by city
 https://api.openweathermap.org/data/2.5/weather?q=Dnipro&appid=3256cb7f2fb7edca2796fc3eab482a46&lang=ua
 
 //URL examples 5 days / 3 hours
 https://api.openweathermap.org/data/2.5/forecast?lat=48.4680221&lon=35.0417711&appid=3256cb7f2fb7edca2796fc3eab482a46
 
 //Geocoder API
 https://api.openweathermap.org/geo/1.0/direct?q=Dnipro&appid=3256cb7f2fb7edca2796fc3eab482a46
 
 //Reverse geocoding
 https://api.openweathermap.org/geo/1.0/reverse?lat=48.4680221&lon=35.0417711&appid=3256cb7f2fb7edca2796fc3eab482a46
 
 */
