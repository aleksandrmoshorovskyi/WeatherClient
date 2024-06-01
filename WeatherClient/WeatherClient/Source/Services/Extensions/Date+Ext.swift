//
//  Date+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 31.05.2024.
//

import Foundation

extension Date {
    
    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            
            dateComponents.timeZone = NSTimeZone.system
            
            return calender.date(from: dateComponents)
        }
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func dateDistance(_ startDate: Date = Date()) -> String {
        
        var remainingTime = ""
        
        let dateValue = Calendar.current.dateComponents(
            [.year,.month,.weekOfMonth,.day,.hour,.minute,.second],
            from: startDate,
            to: self
        )
        
        remainingTime = String(format: "%2d Y - %2d M - %2d W - %2d D\n%02d:%02d:%02d",
                            dateValue.year ?? 0,
                            dateValue.month ?? 0,
                            dateValue.weekOfMonth ?? 0,
                            dateValue.day ?? 0,
                            dateValue.hour ?? 0,
                            dateValue.minute ?? 0,
                            dateValue.second ?? 0
                  )
        
        return remainingTime
    }
}
