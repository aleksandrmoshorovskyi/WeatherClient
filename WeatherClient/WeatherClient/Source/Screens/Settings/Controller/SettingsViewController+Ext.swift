//
//  SettingsViewController+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import UIKit

// MARK: - SettingsViewDelegate
extension SettingsViewController: SettingsViewDelegate {

    func cityRowDidTapAt(_ indexPath: IndexPath) {
        
        /*
        let vc = MainViewController()
            
        vc.currentPage = indexPath
            
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(vc, animated: true)
         */
        
        if let navigationController = navigationController {
            //let vc = navigationController.topViewController as? MainViewController
            //vc?.currentPage = indexPath
            //navigationController.pushViewController(settingsViewController, animated: true)
            
            if let rootVC = navigationController.viewControllers.first as? MainViewController {
                rootVC.currentPage = indexPath
                //rootVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            }
            //navigationController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            navigationController.popViewController(animated: true)?.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        }
    }
}

// MARK: - SettingsModelDelegate
extension SettingsViewController: SettingsModelDelegate {
    
    func citiesDidLoad(with cities: [City]) {
        contentView.setupCities(data: cities)
    }
    
    func dataDidLoad(with data: [City]) {
        contentView.setupCities(data: data)
    }
}
