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
        
        //test
        /*
        DispatchQueue.global(qos: .default).async { [weak self] in
            
            let location = Location(latitude: 49.989619, longitude: 36.241182)
            
            self?.networkService.loadWrather(for: location) { weatherInfo, error in
                
                DispatchQueue.main.async { [weak self] in
                    if let weather = weatherInfo {
                        debugPrint("\(weather.main.temp)")
                        self?.mainLabel.text = "\(weather.main.temp)"
                    }
                }
            }
        }
         */
        
        //test
        /*
        let location = Location(latitude: 49.989619, longitude: 36.241182)
        networkService.loadCoordWrather(for: location) { [weak self] weatherInfo, error in
        //networkService.loadCityWrather(for: "Dnipro") { [weak self] weatherInfo, error in
            if let weather = weatherInfo {
                debugPrint("\(weather.main.temp)")
                self?.mainLabel.text = "\(weather.main.temp)"
            }
        }
         */
                
        let location = Location(latitude: 49.989619, longitude: 36.241182)
        networkService.loadCity(for: location) { [weak self] geoInfo, error in
            
            if let err = error {
                debugPrint("\(err.localizedDescription)")
            }
            
            if let geo = geoInfo {
                debugPrint("\(geo[0].name)")
                self?.mainLabel.text = "\(geo[0].name)"
            }
        }
            
        
    }
}
