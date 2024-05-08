//
//  DMWeatherInfo.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import Foundation

/// DM - Domain Model
struct DMWeatherInfo: Decodable {
    
    let id: Int
    let name: String
    let weather: [Weather]
    let main: Main
    let visibility: Double
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: SysStruct
    let timezone: Int
    let cod: Int
    
    struct Weather: Decodable {
        
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Decodable {
        
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Double
        let humidity: Double
        let seaLevel: Double
        let grndLevel: Double
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }
    
    struct Wind: Decodable {
        
        let speed: Double
        let deg: Double
        let gust: Double
    }
    
    struct Clouds: Decodable {
        
        let all: Double
    }
    
    struct SysStruct: Decodable {
        
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}

/*
 
 {
     "coord": {
         "lon": 34.9833,
         "lat": 48.45
     },
     "weather": [
         {
             "id": 803,
             "main": "Clouds",
             "description": "рвані хмари",
             "icon": "04d"
         }
     ],
     "base": "stations",
     "main": {
         "temp": 287.93,
         "feels_like": 286.27,
         "temp_min": 287.93,
         "temp_max": 287.93,
         "pressure": 1020,
         "humidity": 31,
         "sea_level": 1020,
         "grnd_level": 1009
     },
     "visibility": 10000,
     "wind": {
         "speed": 4.23,
         "deg": 5,
         "gust": 4.77
     },
     "clouds": {
         "all": 58
     },
     "dt": 1715175529,
     "sys": {
         "country": "UA",
         "sunrise": 1715134156,
         "sunset": 1715187830
     },
     "timezone": 10800,
     "id": 709930,
     "name": "Dnipro",
     "cod": 200
 }
 
 */

