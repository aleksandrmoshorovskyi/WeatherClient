//
//  ServiceProvider.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import Foundation

class ServiceProvider {
    
    static func networkService() -> NetworkServiceProtocol {
        let service = NetworkService()
        return service
    }
    
    static func coreDataService() -> CoreDataServiceProtocol {
        let service = CoreDataService.shared
        return service
    }
}
