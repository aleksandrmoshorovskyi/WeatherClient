//
//  WeatherHourlyCellCode+CollectionView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 31.05.2024.
//

import UIKit

// MARK: UICollectionViewDataSource
extension WeatherHourlyCellCode: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        var cellCount = 0
        
        if let data = dataSource {
            cellCount = data.count
        }
        
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherHourlyDetailCellCode.idintifier,
            for: indexPath) as? WeatherHourlyDetailCellCode
        else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        if let data = dataSource {
            cell.hourLabel.text = data[indexPath.row].time
            //cell.iconImage.image = UIImage(systemName: "sun.max.fill")
            
            let iconID = data[indexPath.row].icon
            
            //let urlString = "https://openweathermap.org/img/wn/\(iconID).png"
            //let url = URL(string: urlString)!
            
            //let imageView: UIImageView = UIImageView()
            //imageView.load(url: url)
            
            //cell.iconImage.load(url: url)
            
            cell.iconLabel.text =  Icon.getIconByCode(iconID)
            
            cell.detailLabel.text = data[indexPath.row].desc
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension WeatherHourlyCellCode: UICollectionViewDelegate {

}

// MARK: UICollectionViewDelegateFlowLayout
extension WeatherHourlyCellCode: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return CGSize(width: collectionView.bounds.height/2, height: collectionView.bounds.height)
        return CGSize(width: 70.0, height: collectionView.frame.height)
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
