//
//  DMGeocoder.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import Foundation

struct DMGeocoder: Decodable {
    
    let name: String
    let localNames: LocalNames
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
        
        let uk: String
        let en: String
    }
}

/*
 [
     {
         "name": "Dnipro",
         "local_names": {
             "hr": "Dnjipro",
             "pl": "Dniepr",
             "io": "Dnipro",
             "nl": "Dnipro",
             "et": "Dnipro",
             "eo": "Dnipro",
             "sl": "Dnipro",
             "uk": "Дніпро",
             "de": "Dnipro",
             "he": "דניפרו",
             "oc": "Dnipro",
             "ml": "ഡിനിപ്രോ",
             "be": "Дніпро",
             "fr": "Dnipro",
             "es": "Dnipró",
             "ar": "دنيبرو",
             "fi": "Dnipro",
             "ja": "ドニプロ",
             "ur": "دنیپرو",
             "el": "Ντνίπρο",
             "tr": "Dinipro",
             "cs": "Dnipro",
             "ru": "Днепр",
             "zh": "第聂伯罗",
             "en": "Dnipro",
             "ko": "드니프로",
             "hi": "दनीप्रो",
             "hu": "Dnyipro",
             "sk": "Dnipro",
             "it": "Dnipro",
             "sr": "Дњепро"
         },
         "lat": 48.4680221,
         "lon": 35.0417711,
         "country": "UA",
         "state": "Dnipropetrovsk Oblast"
     }
 ]
 */
