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
        
        var numberOfItems = 1
        
        if dataSource != nil {
            numberOfItems = 9
        }
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
            
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherMainCellCode.idintifier,
                for: indexPath) as? WeatherMainCellCode
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            //debugPrint("\(currentCity.name)")
            cell.cityNameLabel?.text = currentCity.name
            //debugPrint("\(String(describing: cell.cityNameLabel?.text))")
            cell.tempLabel?.text = "- -"
            cell.weatherDescLabel?.text = ""
            
            if let data = dataSource {
                cell.cityNameLabel?.text = data.city
                //debugPrint("\(String(describing: cell.cityNameLabel?.text))")
                
                let tempStr = String(format: "%.0f" , data.temp)
                cell.tempLabel?.text = "\(tempStr) ℃"
                
                cell.weatherDescLabel?.text = data.desc
            }
     
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherHourlyCellCode.idintifier,
                for: indexPath) as? WeatherHourlyCellCode
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "hourly forecast".uppercased()
            
            if let data = dataSource {
                cell.dataSource = data.hourlyForecast
            }
     
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherDayliCell.idintifier,
                for: indexPath) as? WeatherDayliCell
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "5-day forecast".uppercased()
            
            if let data = dataSource {
                cell.dataSource = data.dayliForecast
            }
     
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherPressureCell.idintifier,
                for: indexPath) as? WeatherPressureCell
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "pressure".uppercased()
            cell.valueLabel.text = "-"
            
            if let data = dataSource {
                cell.valueLabel.text = "\(data.pressure)"
            }
     
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherFeelsLikeCell.idintifier,
                for: indexPath) as? WeatherFeelsLikeCell
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "humidity".uppercased()
            cell.valueLabel.text = "-"
            
            if let data = dataSource {
                cell.valueLabel.text = "\(data.humidity)"
            }
     
            return cell
            
        case 5:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherFeelsLikeCell.idintifier,
                for: indexPath) as? WeatherFeelsLikeCell
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "feels like".uppercased()
            cell.valueLabel.text = "-"
            
            if let data = dataSource {
                cell.valueLabel.text = "\(data.feelsLike)"
            }
     
            return cell
            
        case 6:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherWindCell.idintifier,
                for: indexPath) as? WeatherWindCell
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "wind".uppercased()
            cell.valueLabel.text = "-"
            
            if let data = dataSource {
                cell.valueLabel.text = "\(data.wind?.speed ?? 0.0)"
            }
     
            return cell
            
        case 7:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherSunRiseSetCell.idintifier,
                for: indexPath) as? WeatherSunRiseSetCell
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "sunrise".uppercased()
            cell.valueLabel.text = "-"
            
            if let data = dataSource {
                cell.valueLabel.text = "\(data.sys?.sunrise ?? 0)"
            }
     
            return cell
            
        case 8:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherVisibilityCell.idintifier,
                for: indexPath) as? WeatherVisibilityCell
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "visibility".uppercased()
            cell.valueLabel.text = "-"
     
            if let data = dataSource {
                cell.valueLabel.text = "\(data.visibility ?? 0)"
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
    }
}

// MARK: UICollectionView - Delegate
extension WeatherView: UICollectionViewDelegate {

}

// MARK: UICollectionView - DelegateFlowLayout
extension WeatherView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return CGSize(width: collectionView.bounds.width, height: 300.0)
        //return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width/2)
        //return CGSize(width: 100.00, height: 100.00)
        
        switch indexPath.row {
            
        case 0:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width)
            
        case 1:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width/2)
            
        case 2:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width)
            
        case 3...8:
            return CGSize(width: collectionView.bounds.width/2, height: collectionView.bounds.width/2)
            
        default:
            return .zero
        }
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

