//
//  NetworkService+Weather.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import Foundation

typealias WeatherInfoCompletion = ((DMWeatherInfo?, Error?) -> ())
typealias GeocoderCompletion = (([DMGeocoder]?, Error?) -> ())

protocol NetworkServiceWeather {
    
    func loadCoordWrather(for location: Location, completion: @escaping WeatherInfoCompletion)
    func loadCityWrather(for city: String, completion: @escaping WeatherInfoCompletion)
    func loadCity(for location: Location, completion: @escaping GeocoderCompletion)
}

// MARK: - NetworkService+Weather
extension NetworkService: NetworkServiceWeather {

    func loadCoordWrather(for location: Location, completion: @escaping (DMWeatherInfo?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.weatherUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstant.appId)"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        request(urlRequest: urlRequest) { (result: Result<DMWeatherInfo,Error>) in
            
            switch result {
            case .success(let value):
                completion(value, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func loadCityWrather(for city: String, completion: @escaping (DMWeatherInfo?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.weatherUrl())?q=\(city)&appid=\(APIConstant.appId)"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        request(urlRequest: urlRequest) { (result: Result<DMWeatherInfo,Error>) in
            
            switch result {
            case .success(let value):
                completion(value, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func loadCity(for location: Location, completion: @escaping ([DMGeocoder]?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.reverseGeocoderUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstant.appId)"
        
        loadGeocoder(for: urlString, completion: completion)
    }
    
    private func loadGeocoder(for urlString: String, completion: @escaping ([DMGeocoder]?, Error?) -> ()) {
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        request(urlRequest: urlRequest) { (result: Result<[DMGeocoder], Error>) in
            
            switch result {
            case .success(let value):
                completion(value, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
