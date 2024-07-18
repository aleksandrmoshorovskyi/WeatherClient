//
//  City.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import Foundation

struct CityDataModel {
    
    //let id: ObjectIdentifier
    let name: String
    let latitude: Float
    let longitude: Float
    let state: String?
    let country: String?
    var order: Int?
}
