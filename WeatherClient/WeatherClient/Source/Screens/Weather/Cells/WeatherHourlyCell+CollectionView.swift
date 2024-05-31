//
//  WeatherHourlyCell+CollectionView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 31.05.2024.
//

import UIKit

// MARK: UICollectionViewDataSource
extension WeatherHourlyCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        var cellCount = 0
        
        if let data = dataSource {
            cellCount = data.count
        }
        
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherHourlyDetailCell.idintifier,
            for: indexPath) as? WeatherHourlyDetailCell
        else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        if let data = dataSource {
            cell.hourLabel.text = data[indexPath.row].time
            cell.iconImage.image = UIImage(systemName: "sun.max.fill")
            cell.detailLabel.text = data[indexPath.row].desc
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension WeatherHourlyCell: UICollectionViewDelegate {

}

// MARK: UICollectionViewDelegateFlowLayout
extension WeatherHourlyCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.height/2, height: collectionView.bounds.height)
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
