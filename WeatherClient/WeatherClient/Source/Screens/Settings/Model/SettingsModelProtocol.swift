//
//  SettingsModelProtocol.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

protocol SettingsModelProtocol {
    
    func loadData()
    func loadSearchData(for string: String)
    
    func deleteCity(_ item: City)
}
