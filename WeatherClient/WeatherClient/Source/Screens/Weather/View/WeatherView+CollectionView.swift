//
//  WeatherView+CollectionView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import UIKit

// MARK: UICollectionView - DataSource
extension WeatherView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherMainCell.idintifier,
            for: indexPath) as? WeatherMainCell
        else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        cell.cityNameLabel?.text = currentCity
        cell.tempLabel?.text = "- -"
        cell.weatherDescLabel?.text = ""
        
        if let data = dataSource {
            cell.cityNameLabel?.text = data.city
            
            let tempStr = String(format: "%.0f" , data.temp)
            cell.tempLabel?.text = "\(tempStr) ℃"
            
            cell.weatherDescLabel?.text = data.desc
        }
 
        return cell
    }
}

// MARK: UICollectionView - Delegate
extension WeatherView: UICollectionViewDelegate {

}

// MARK: UICollectionView - DelegateFlowLayout
extension WeatherView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return CGSize(width: collectionView.bounds.width, height: 300.0)
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width)
        //return CGSize(width: 100.00, height: 100.00)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return .zero
    }
}

