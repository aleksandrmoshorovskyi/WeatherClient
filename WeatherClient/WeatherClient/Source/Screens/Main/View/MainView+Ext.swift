//
//  MainView+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import Foundation

// MARK: - MainViewProtocol
extension MainView: MainViewProtocol {
    
    func setupCurrentPageAt(_ indexPath: IndexPath) {
        
        //debugPrint("currentPage - \(String(describing: currentPage))")
        
        currentPage = indexPath
        
        //debugPrint("currentPage - \(String(describing: currentPage))")
        
        if let page = currentPage {
            //collectionView.layoutIfNeeded()
            //scrollToIndex(index: page.row)
            
            collectionView.scrollToItem(at: page, at: .centeredHorizontally, animated: false)
            
            mainPageControl.currentPage = page.row
            
            currentPage = nil
        }
    }
    
    
    func setupWeather(data: [WeatherViewController]) {
        
        dataSourceAr = data
        if let dataSource = dataSourceAr {
            mainPageControl.numberOfPages = dataSource.count
        }
        
        collectionView.reloadData()
    }
}
