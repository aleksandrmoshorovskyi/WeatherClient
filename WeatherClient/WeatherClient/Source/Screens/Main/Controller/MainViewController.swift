//
//  MainViewController.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    var mainLabel: UILabel!
    
    let networkService = ServiceProvider.networkService()
    
    override func loadView() {
        
        print("loadView")
        
        let mainView = UIView()
        mainView.backgroundColor = .red
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        
        //test
        mainLabel = UILabel(frame: CGRect(
            x: 150.0,
            y: 250.0,
            width: 100.0,
            height: 100.0
        ))
        
        mainLabel.textColor = .white
        
        view.addSubview(mainLabel)
        
        //API tests
        APITests().testloadCityForLocation()
        APITests().testloadLocationForCity()
        
        APITests().testLoadCurrentWeatherForLocation()
        APITests().testLoadCurrentWeatherForLocationWithParams()
        APITests().testLoadCurrentWeatherForCity()
        APITests().testLoadCurrentWeatherForCityWithParams()
        
        APITests().testLoadForecastForLocation()
        APITests().testLoadForecastForLocationWithParams()
        APITests().testLoadForecastForCity()
        APITests().testLoadForecastForCityWithParams()
    }
}
