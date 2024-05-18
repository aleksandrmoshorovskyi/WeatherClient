//
//  SettingsViewController.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var model: SettingsModelProtocol!
    
    var contentView: SettingsViewProtocol!
    
    override func loadView() {
        
        //setupInitialState()
        //model.loadData()
        
        let settingsView = SettingsView()
        //settingsView.backgroundColor = .red
        settingsView.delegate = self
        
        contentView = settingsView
        
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        let settingsModel = SettingsModel(delegate: self)
        
        model = settingsModel
    }
}
