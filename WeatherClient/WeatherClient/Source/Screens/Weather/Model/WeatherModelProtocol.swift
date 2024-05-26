//
//  WeatherModelProtocol.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 15.05.2024.
//

import Foundation

protocol WeatherModelProtocol {
    
//    func loadData(for city: String)
//    func checkCity(with name: String)
//    func addCity(with name: String)
    
    func loadData(for city: CityDataModel)
    func checkCity(_ city: CityDataModel)
    func addCity(_ city: CityDataModel)
}
