//
//  DMWeatherInfoList.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 09.05.2024.
//

import Foundation

struct DMWeatherInfoList: Decodable {
    
    let cod: String
    let message: Int
    let cnt: Int
    let list: [List]
    let city: City
    
    struct List: Decodable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Float?
        let pop: Float
        let sys: Sys
        let dtTxt: String
        
        struct Main: Decodable {
            
            let temp: Float
            let feelsLike: Float
            let tempMin: Float
            let tempMax: Float
            let pressure: Float
            let seaLevel: Float
            let grndLevel: Float
            let humidity: Float
            let tempKf: Float
            
            enum CodingKeys: String, CodingKey {
                case temp
                case feelsLike = "feels_like"
                case tempMin = "temp_min"
                case tempMax = "temp_max"
                case pressure
                case seaLevel = "sea_level"
                case grndLevel = "grnd_level"
                case humidity
                case tempKf = "temp_kf"
            }
        }
        
        struct Weather: Decodable {
            
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        struct Clouds: Decodable {
            
            let all: Float
        }
        
        struct Wind: Decodable {
            
            let speed: Float
            let deg: Float
            let gust: Float
        }
        
        struct Sys: Decodable {
            
            let pod: String
        }
         
        enum CodingKeys: String, CodingKey {
            case dt
            case main
            case weather
            case clouds
            case wind
            case visibility
            case pop
            case sys
            case dtTxt = "dt_txt"
        }
    }
    
    struct City: Decodable {
        
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population: Int
        let timezone: Int
        let sunrise: Int
        let sunset: Int
        
        struct Coord: Decodable {
            
            let lat: Float
            let lon: Float
        }
    }
}
