//
//  DMWeatherInfo.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import Foundation

/// DM - Domain Model
struct DMWeatherInfo: Decodable {
    
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Float
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    struct Coord: Decodable {
        
        let lat: Float
        let lon: Float
    }
    
    struct Weather: Decodable {
        
        let id: Int
        let main: String
        let descWeather: String
        let icon: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case main
            case descWeather = "description"
            case icon
        }
    }
    
    struct Main: Decodable {
        
        let temp: Float
        let feelsLike: Float
        let tempMin: Float
        let tempMax: Float
        let pressure: Float
        let humidity: Float
        let seaLevel: Float?
        let grndLevel: Float?
        
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
        
        let speed: Float
        let deg: Float
        let gust: Float
    }
    
    struct Clouds: Decodable {
        
        let all: Double
    }
    
    struct Sys: Decodable {
        
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


