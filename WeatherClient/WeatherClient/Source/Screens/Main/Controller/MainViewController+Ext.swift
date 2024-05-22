//
//  MainViewController+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import UIKit

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    
    func cityListButtonDidTap() {
        
        let settingsViewController = SettingsViewController()

        /*
        settingsViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        settingsViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(settingsViewController, animated: true)
         */
        
        if let navigationController = navigationController {
            navigationController.pushViewController(settingsViewController, animated: true)
            //navigationController.popViewController(animated: true)
        }
    }
    
    func cityDidTap() {
//        model.loadData()
    }
}

// MARK: - MainModelDelegate
extension MainViewController: MainModelDelegate {
    

    func dataDidLoad(with data: [WeatherViewController]) {

        contentView.setupWeather(data: data)
        
        if let page = currentPage {
            contentView.setupCurrentPageAt(page)
        }
        
        if data.isEmpty {
            let settingsViewController = SettingsViewController()
            if let navigationController = navigationController {
                navigationController.pushViewController(settingsViewController, animated: true)
                //navigationController.popViewController(animated: true)
            }
        }
    }
}
