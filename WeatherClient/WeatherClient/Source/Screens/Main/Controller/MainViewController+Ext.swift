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
        pushSettingsViewController()
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
            currentPage = nil
        }
        
        if data.isEmpty {
            pushSettingsViewController()
        }
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    
    func dataDidChange() {
        model.loadData()
    }
}
