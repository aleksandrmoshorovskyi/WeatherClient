//
//  WeatherViewController.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 15.05.2024.
//

import UIKit

class WeatherViewController: UIViewController {
    
    weak var delegate: WeatherViewControllerDelegate?
    
    var model: WeatherModelProtocol!
    var contentView: WeatherViewProtocol!
    
    //var currentCity: String!
    var currentCity: CityDataModel!
    var dataSource: WeatherDataModel!
    var isPresent = false
    
    override func loadView() {
        
        //debugPrint("WeatherViewController - loadView")
        
        let weatherView = WeatherView()
        weatherView.delegate = self
        weatherView.currentCity = currentCity
        
        contentView = weatherView
        
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = Constant.mainColor
        
        if let data = dataSource {
            contentView?.setupWeather(data: data)
        }
        
        if isPresent {
            contentView.setupCancelButton()
            //model.checkCity(with: currentCity)
            model.checkCity(currentCity)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //contentView.reloadWeatherData()
    }
    
    private func setupInitialState() {
        
        let weatherModel = WeatherModel(delegate: self)
        model = weatherModel
    }
    
//    func doSomething(with str: String) {
//        
//        //debugPrint("Hello VC - \(str)")
//        
//        currentCity = str
//        
//        setupInitialState()
//        model.loadData(for: str)
//    }
    
    func loadWeatherData(for city: CityDataModel) {
        
        currentCity = city
        
        setupInitialState()
        model.loadData(for: city)
    }
}
