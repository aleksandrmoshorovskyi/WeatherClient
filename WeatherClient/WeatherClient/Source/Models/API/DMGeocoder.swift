//
//  DMGeocoder.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import Foundation

struct DMGeocoder: Decodable {
    
    let name: String
    let localNames: LocalNames?
    let lat: Float
    let lon: Float
    let country: String
    let state: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat
        case lon
        case country
        case state
    }
    
    struct LocalNames: Decodable {
        
        let uk: String?
        let en: String?
    }
}

/*
 [
     {
         "name": "Dnipro",
         "local_names": {       //?
             "uk": "Дніпро",    //?
             "en": "Dnipro"     //?
         },
         "lat": 48.4680221,
         "lon": 35.0417711,
         "country": "UA",
         "state": "Dnipropetrovsk Oblast"
     }
 ]
 */
