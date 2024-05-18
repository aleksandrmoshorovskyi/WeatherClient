//
//  MainModelDelegate.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import Foundation

protocol MainModelDelegate: AnyObject {
    
    func dataDidLoad(with data: [WeatherViewController])
}
