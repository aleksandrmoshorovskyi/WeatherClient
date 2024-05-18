//
//  WeatherViewController.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 15.05.2024.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var model: WeatherModelProtocol!
    var contentView: WeatherViewProtocol!
    
    var currentCity: String!
    var dataSource: Weather!
    
    //var cityLabel: UILabel!
    //var label: UILabel!
    
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
        
        view.backgroundColor = Constant.mainColor
        
//        cityLabel = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
//        
//        label = UILabel(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
//        
//        view.addSubview(cityLabel)
//        view.addSubview(label)
//        
//        setupData()
        
        //setupInitialState()
        //model.loadData()
        
        if let data = dataSource {
            contentView?.setupWeather(data: data)
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
    
//    func setupData() {
//        
//        cityLabel?.text = currentCity
//        
//        if let data = dataSource {
//            cityLabel?.text = "\(data.name)"
//            let tempStr = String(format: "%.0f" , data.main.temp)
//            label?.text = "\(tempStr) ℃"
//        }
//    }
    
    func doSomething(with str: String) {
        
        //debugPrint("Hello VC - \(str)")
        
        currentCity = str
        
        setupInitialState()
        model.loadData(for: str)
    }
}
