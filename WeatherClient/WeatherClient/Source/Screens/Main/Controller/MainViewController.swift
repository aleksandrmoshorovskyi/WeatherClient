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
    
    var currentPage: IndexPath?
    
    override func loadView() {
        
        //debugPrint("MainVC - loadView")
        
        let mainView = MainView()
        mainView.backgroundColor = .red
        mainView.delegate = self
        mainView.currentPage = currentPage
        
        contentView = mainView
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //debugPrint("MainVC - viewDidLoad")
        
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        let mainModel = MainModel(delegate: self)
        model = mainModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //debugPrint("MainVC - viewWillAppear")
        
        setupCurrentPageAt()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        //debugPrint("MainVC - viewIsAppearing")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //debugPrint("MainVC - viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //debugPrint("MainVC - viewDidLayoutSubviews")
        
        //setupCurrentPageAt()
        
        //nw_connection_add_timestamp_locked_on_nw_queue [C1] Hit maximum timestamp count, will start dropping events
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //debugPrint("MainVC - viewDidAppear")
        
        if let navigationController = navigationController {
            navigationController.navigationItem.titleView?.backgroundColor = .blue
        }
    }
    
    func pushSettingsViewController() {
        
        if let navigationController = navigationController {
        
            if let topViewController = navigationController.topViewController {
                if topViewController.isKind(of: SettingsViewController.self) {
                    
                    navigationController.popToViewController(topViewController, animated: true)
                } else {
                    
                    let settingsViewController = SettingsViewController()
                    settingsViewController.delegate = self
                    
                    navigationController.pushViewController(settingsViewController, animated: true)
                }
            }
        }
    }
    
    func setupCurrentPageAt() {
        if let page = currentPage {
            contentView.setupCurrentPageAt(page)
            currentPage = nil
        }
    }
}
