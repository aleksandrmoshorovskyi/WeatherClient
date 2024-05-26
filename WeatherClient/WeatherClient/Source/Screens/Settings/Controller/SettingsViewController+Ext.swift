//
//  SettingsViewController+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import UIKit

// MARK: - SettingsViewDelegate
extension SettingsViewController: SettingsViewDelegate {
    
    func swapAt(_ sourceCity: CityDataModel, _ destinationCity: CityDataModel) {
        model.swapCities(sourceCity, destinationCity)
        delegate?.dataDidChange()
    }
    
    func cityRowDeleteAt(_ city: CityDataModel) {
        //model.deleteCity(city)
        model.deleteCity(for: city)
        delegate?.dataDidChange()
    }

    func cityRowDidTapAt(_ indexPath: IndexPath) {
        
        //debugPrint("cityRowDidTapAt")
        
        if let navigationController = navigationController {
            
            //debugPrint("navigationController not nil")
            
            //debugPrint("navigationControllers - \(navigationController.viewControllers)")

            if let rootVC = navigationController.viewControllers.first as? MainViewController {
                //debugPrint("rootVC = \(rootVC)")
                rootVC.currentPage = indexPath
            }
            
            let popvc = navigationController.popViewController(animated: true)//.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            //debugPrint("popvc - \(String(describing: popvc))")
        }
        
    }
}

// MARK: - SettingsModelDelegate
extension SettingsViewController: SettingsModelDelegate {
    
    func searchDataDidLoad(with data: [SearchDataModel]) {
        //data source for searching
        serchDataSource = data
        resultsTableController.tableView.reloadData()
    }
    
    func citiesDidLoad(with cities: [CityWeatherDataModel]) {
        contentView.setupCities(data: cities)
    }
    
    func dataDidLoad(with data: [CityWeatherDataModel]) {
        contentView.setupCities(data: data)
    }
}
