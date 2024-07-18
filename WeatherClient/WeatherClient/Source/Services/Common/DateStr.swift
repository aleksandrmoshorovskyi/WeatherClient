//
//  DateStr.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import Foundation

class DateStr {
    
    static func timeFromDateInterval(_ timeInterval: Int?, like formatter: String) -> String {
        
        var str = ""
        
        if let timeInt = timeInterval {
            let dateFormatter = DateFormatter()
            let date = Date(timeIntervalSince1970: TimeInterval(timeInt))
             
            // US English Locale (en_US)
            //dateFormatter.locale = Locale(identifier: "en_US")
            //dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd") // set template after setting locale
            //print(dateFormatter.string(from: date)) // December 31
            
            //dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
            dateFormatter.setLocalizedDateFormatFromTemplate(formatter)
            
            str = dateFormatter.string(from: date)
        } else {
            str = "n/a"
        }
        
        return str
    }
}

/*
 Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
 09/12/2018                        --> MM/dd/yyyy
 09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
 Sep 12, 2:11 PM                   --> MMM d, h:mm a
 September 2018                    --> MMMM yyyy
 Sep 12, 2018                      --> MMM d, yyyy
 Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
 2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
 12.09.18                          --> dd.MM.yy
 10:41:02.112                      --> HH:mm:ss.SSS
 */

/*
 Era: G (AD), GGGG (Anno Domini)
 Year: y (2018), yy (18), yyyy (2018)
 Month: M, MM, MMM, MMMM, MMMMM
 Day of month: d, dd
 Day name of week: E, EEEE, EEEEE, EEEEEE
 */
