//
//  Weather.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import Foundation

struct WeatherDataModel {
    
    let city: String
    let desc: String
    let temp: Float
    let tempMin: Float
    let tempMax: Float
    
    let pressure: Float
    let humidity: Float
    let feelsLike: Float
    
    let wind: Wind?
    
    let sys: Sys?
    let visibility: Float?
    
    var hourlyForecast: [HourlyForecast]?
    var dayliForecast: [DayliForecast]?
}

struct Wind {
    
    let speed: Float
    let deg: Float
    let gust: Float
}

struct Sys {
    
    let sunrise: Int
    let sunset: Int
}

struct HourlyForecast {
    
    let dt: Int
    let time: String
    let icon: String
    let desc: String
}

struct DayliForecast {
    
    let dt: Int
    let day: String
    let icon: String
    let tempMin: String
    let tempMax: String
}
