//
//  NetworkService+Weather.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import Foundation

typealias WeatherInfoCompletion = ((DMWeatherInfo?, Error?) -> ())
typealias WeatherInfoListCompletion = (DMWeatherInfoList?, Error?) -> ()
typealias GeocoderCompletion = (([DMGeocoder]?, Error?) -> ())

protocol NetworkServiceWeather {
    
    //current weater for coordinates or city
    func loadCoordWrather(for location: Location, completion: @escaping WeatherInfoCompletion)
    func loadCityWrather(for city: String, completion: @escaping WeatherInfoCompletion)
    
    //forecast for coordinates or city
    func loadCoordWratherForecast(for location: Location, completion: @escaping WeatherInfoListCompletion)
    func loadCityWratherForecast(for city: String, completion: @escaping WeatherInfoListCompletion)
    
    //geocoder or reverseGeocoder
    func loadCoord(for city: String, completion: @escaping GeocoderCompletion)
    func loadCity(for location: Location, completion: @escaping GeocoderCompletion)
}

// MARK: - NetworkService+Weather
extension NetworkService: NetworkServiceWeather {

    func loadCoordWrather(for location: Location, completion: @escaping (DMWeatherInfo?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.weatherUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstant.appId)"
        
        loadData(for: urlString, completion: completion)
    }
    
    func loadCityWrather(for city: String, completion: @escaping (DMWeatherInfo?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.weatherUrl())?q=\(city)&appid=\(APIConstant.appId)"
        
        loadData(for: urlString, completion: completion)
    }
    
    func loadCoordWratherForecast(for location: Location, completion: @escaping (DMWeatherInfoList?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.forecastUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstant.appId)"
        
        loadData(for: urlString, completion: completion)
    }
    
    func loadCityWratherForecast(for city: String, completion: @escaping (DMWeatherInfoList?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.forecastUrl())?q=\(city)&appid=\(APIConstant.appId)"
        
        loadData(for: urlString, completion: completion)
    }
    
    func loadCity(for location: Location, completion: @escaping ([DMGeocoder]?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.reverseGeocoderUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstant.appId)"
        
        loadData(for: urlString, completion: completion)
    }
    
    func loadCoord(for city: String, completion: @escaping ([DMGeocoder]?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.geocoderUrl())?q=\(city)&appid=\(APIConstant.appId)&limit=0"
        
        loadData(for: urlString, completion: completion)
    }
    
    private func loadData<T: Decodable>(for urlString: String, completion: @escaping (T?, Error?) -> ()) {
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        request(urlRequest: urlRequest) { (result: Result<T, Error>) in
            
            switch result {
            case .success(let value):
                completion(value, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
