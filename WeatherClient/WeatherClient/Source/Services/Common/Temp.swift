//
//  Temp.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 31.05.2024.
//

import Foundation

class Temp {
    
    static func stringTemp(_ temp: Float) -> String {
        
        //" ℃ "
        //" ℉ "
        
        var tempStr = String(format: "%.0f" , temp)
        tempStr = "\(tempStr)°"
        
        return tempStr
    }
}
