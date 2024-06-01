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
            return "☀️"
        case "02d":
            return "🌤️"
        case "03d":
            return "🌥️"
        case "04d":
            return "☁️"
        case "09d":
            return "🌧️"
        case "10d":
            return "🌦️"
        case "11d":
            return "⛈️"
        case "13d":
            return "❄️"
        case "50d":
            return "🌫️"
            
        case "01n":
            return "🌕"
        case "02n":
            return "☁️"
        case "03n":
            return "☁️"
        case "04n":
            return "☁️"
        case "09n":
            return "🌧️"
        case "10n":
            return "🌦️"
        case "11n":
            return "⛈️"
        case "13n":
            return "❄️"
        case "50n":
            return "🌫️"
            
        case "sunrise":
            return "🌅"
        case "sunset":
            return "🌆"
            
        default:
            debugPrint("\(code)")
            return "🚫"
        }
    }
}
