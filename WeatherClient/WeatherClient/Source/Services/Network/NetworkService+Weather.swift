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
typealias WeatherParametrs = (units: Units?, lang: Lang?)

protocol NetworkServiceWeather {
    
    //current weater for coordinates or city
    func loadWeatherForLocation(_ location: Location, completion: @escaping WeatherInfoCompletion)
    func loadWeatherForLocation(_ location: Location, with params: WeatherParametrs, completion: @escaping WeatherInfoCompletion)
    func loadWeatherForCity(_ city: String, completion: @escaping WeatherInfoCompletion)
    func loadWeatherForCity(_ city: String , with params: WeatherParametrs, completion: @escaping WeatherInfoCompletion)
    
    //forecast for coordinates or city
    func loadWeatherForecastForLocation(_ location: Location, completion: @escaping WeatherInfoListCompletion)
    func loadWeatherForecastForLocation(_ location: Location, with params: WeatherParametrs, completion: @escaping WeatherInfoListCompletion)
    func loadWeatherForecastForCity(_ city: String, completion: @escaping WeatherInfoListCompletion)
    func loadWeatherForecastForCity(_ city: String, with params: WeatherParametrs, completion: @escaping WeatherInfoListCompletion)
    
    //geocoder or reverseGeocoder
    func loadWeatherLocation(for city: String, completion: @escaping GeocoderCompletion)
    func loadWeatherCity(for location: Location, completion: @escaping GeocoderCompletion)
}

// MARK: - NetworkService+Weather
extension NetworkService: NetworkServiceWeather {
    
    // MARK: - CURRENT
    func loadWeatherForLocation(_ location: Location, completion: @escaping (DMWeatherInfo?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.weatherUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstant.appId)"
        
        loadData(for: urlString, completion: completion)
    }
    
    func loadWeatherForLocation(_ location: Location, with params: (units: Units?, lang: Lang?), completion: @escaping (DMWeatherInfo?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.weatherUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstant.appId)"
        
        loadData(for: addParametrs(params, for: urlString), completion: completion)
    }
    
    func loadWeatherForCity(_ city: String, completion: @escaping (DMWeatherInfo?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.weatherUrl())?q=\(city)&appid=\(APIConstant.appId)"
        
        loadData(for: urlString, completion: completion)
    }
    
    func loadWeatherForCity(_ city: String, with params: WeatherParametrs, completion: @escaping WeatherInfoCompletion) {
        
        let urlString = "\(APIConstant.weatherUrl())?q=\(city)&appid=\(APIConstant.appId)"
        
        loadData(for: addParametrs(params, for: urlString), completion: completion)
    }
    
    
    // MARK: - FORECAST
    func loadWeatherForecastForLocation(_ location: Location, completion: @escaping (DMWeatherInfoList?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.forecastUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstant.appId)"
        
        loadData(for: urlString, completion: completion)
    }
    
    func loadWeatherForecastForLocation(_ location: Location, with params: WeatherParametrs, completion: @escaping WeatherInfoListCompletion) {
        let urlString = "\(APIConstant.forecastUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstant.appId)"
        
        loadData(for: addParametrs(params, for: urlString), completion: completion)
    }
    
    func loadWeatherForecastForCity(_ city: String, completion: @escaping (DMWeatherInfoList?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.forecastUrl())?q=\(city)&appid=\(APIConstant.appId)"
        
        loadData(for: urlString, completion: completion)
    }
    
    func loadWeatherForecastForCity(_ city: String, with params: WeatherParametrs, completion: @escaping WeatherInfoListCompletion) {
        let urlString = "\(APIConstant.forecastUrl())?q=\(city)&appid=\(APIConstant.appId)"
        
        loadData(for: addParametrs(params, for: urlString), completion: completion)
    }
    
    
    // MARK: - GEOCODERS
    func loadWeatherCity(for location: Location, completion: @escaping ([DMGeocoder]?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.reverseGeocoderUrl())?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstant.appId)"
        
        loadData(for: urlString, completion: completion)
    }
    
    func loadWeatherLocation(for city: String, completion: @escaping ([DMGeocoder]?, Error?) -> ()) {
        
        let urlString = "\(APIConstant.geocoderUrl())?q=\(city)&appid=\(APIConstant.appId)&limit=0"
        
        loadData(for: urlString, completion: completion)
    }
    
    
    // MARK: - common methods
    private func addParametrs(_ params: WeatherParametrs, for urlString: String) -> String {
        
        var tempUrlString = urlString
        
        if let units = params.units {
            tempUrlString += "&units=\(units)"
        }
        
        if let lang = params.lang {
            tempUrlString += "&lang=\(lang)"
        }
        
        return tempUrlString
    }
    
    private func loadData<T: Decodable>(for urlString: String, completion: @escaping (T?, Error?) -> ()) {
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        //MARK: IF WITH CACHE - WRONG WEATHER
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
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
