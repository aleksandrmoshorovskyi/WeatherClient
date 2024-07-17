//
//  Metrics.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import Foundation

class Metrics {
    
    static func strTemp(_ temp: Float, for main: Bool = false) -> String {
        
        //" ℃ "
        //" ℉ "
        
        // 0 - Celsius
        // 1 - Fahrenheit
        
        let kelvinZero: Float = 273.15
        var tempInCurrentUnit = temp

        let defaults = UserDefaults.standard
        let tempUnit = defaults.integer(forKey: "tempUnit")
        
        switch tempUnit {
        case 0:
            tempInCurrentUnit = temp - kelvinZero
        case 1:
            tempInCurrentUnit = (temp * (9.0/5.0) - 459.67)
        default:
            tempInCurrentUnit = temp
        }
        
        var tempStr = String(format: "%.0f" , tempInCurrentUnit)
       
        if main {
            switch tempUnit {
            case 0:
                tempStr = "\(tempStr)℃"
            case 1:
                tempStr = "\(tempStr)℉"
            default:
                tempStr = "\(tempStr)°"
            }
        } else {
            tempStr = "\(tempStr)°"
        }
        
        return tempStr
    }
    
    static func strPressure(_ pressure: Float) -> String {
        
        let str = String(format: "%.0f" , pressure)
        
        return "\(str) hPa"
    }
    
    static func strHumidity(_ humidity: Float) -> String {
        
        let str = String(format: "%.0f" , humidity)
        
        return "\(str)%"
    }
    
    static func strVisibility(_ visibility: Float?) -> String {
        
        var str = ""
        
        if let distance = visibility {
            str = String(format: "%.0f" , distance/1000)
        } else {
            str = "n/a"
        }
        
        return "\(str) km"
    }
    
    //Wind
    static func strWindSpeedGust(_ windSpeed: Float?) -> String {
        
        var str = ""
        
        if let speed = windSpeed {
            str = String(format: "%.0f" , speed)
        } else {
            str = "n/a"
        }
        
        return "\(str) M/S"
    }
    
    static func strWindDeg(_ windDeg: Float?) -> String {
        
        var str = ""
        
        if let deg = windDeg {
            
            switch deg {
            case 0...30:
                str = "N"
            case 30...60:
                str = "NE"
            case 60...120:
                str = "E"
            case 120...150:
                str = "SE"
            case 150...210:
                str = "S"
            case 210...240:
                str = "SW"
            case 240...300:
                str = "W"
            case 300...330:
                str = "NW"
            case 330...360:
                str = "N"
            default:
                str = "n/a"
            }
            
        } else {
            str = "n/a"
        }
        
        return str
    }
    
    static func strWindDegArrow(_ windDeg: Float?) -> String {
        
        var str = ""
        
        if let deg = windDeg {
            
            // ⬆️ ↗️ ➡️ ↘️ ⬇️ ↙️ ⬅️ ↖️
            
            // ↑ ↗ → ↘ ↓ ↙ ← ↖
            
            switch deg {
            case 0...30:
                str = "N ↑"
            case 30...60:
                str = "NE ↗"
            case 60...120:
                str = "E →"
            case 120...150:
                str = "SE ↘"
            case 150...210:
                str = "S ↓"
            case 210...240:
                str = "SW ↙"
            case 240...300:
                str = "W ←"
            case 300...330:
                str = "NW ↖"
            case 330...360:
                str = "N ↑"
            default:
                str = "n/a"
            }
            
        } else {
            str = "n/a"
        }
        
        return str
    }
}
