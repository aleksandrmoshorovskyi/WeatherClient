//
//  Icon.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import Foundation

class Icon {
    
    static func getIconByCode(_ code: String) -> String {
        
        //debugPrint("\(code)")
        
        switch code {
        case "01d":
            return "☀️" //clear sky
        case "02d":
            return "🌤️" //few clouds
        case "03d":
            return "🌥️" //scattered clouds
        case "04d":
            return "☁️" //broken clouds
        case "09d":
            return "🌧️" //shower rain
        case "10d":
            return "🌦️" //rain
        case "11d":
            return "🌩️" //thunderstorm
        case "13d":
            return "❄️" //snow
        case "50d":
            return "🌫️" //mist
            
        case "01n":
            return "🌙"
        case "02n":
            return "☁️"
        case "03n":
            return "☁️"
        case "04n":
            return "☁️"
        case "09n":
            return "🌧️"
        case "10n":
            return "🌧️"
        case "11n":
            return "⚡️"
        case "13n":
            return "❄️"
        case "50n":
            return "🌫️"
            
        case "sunrise":
            return "🌞"
        case "sunset":
            return "🌗"
            
        default:
            debugPrint("\(code)")
            return "🚫"
        }
    }
}
