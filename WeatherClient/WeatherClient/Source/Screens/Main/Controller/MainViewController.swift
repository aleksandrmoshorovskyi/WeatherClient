//
//  MainViewController.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    var model: MainModelProtocol!
    var contentView: MainViewProtocol!
    
    override func loadView() {
        
        let mainView = MainView()
        mainView.backgroundColor = .red
        mainView.delegate = self
        
        contentView = mainView
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        let mainModel = MainModel(delegate: self)
        model = mainModel
    }
}
