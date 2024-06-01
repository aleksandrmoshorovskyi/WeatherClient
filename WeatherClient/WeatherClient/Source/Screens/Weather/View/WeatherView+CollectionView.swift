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
           
        //MainCell
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
                
                /*
                let tempStr = String(format: "%.0f" , data.temp)
                cell.tempLabel?.text = "\(tempStr) ℃"
                 */
                
                cell.tempLabel?.text = Temp.stringTemp(data.temp, for: true)
                
                cell.weatherDescLabel?.text = data.desc
                
                cell.tempMaxLabel.text = "H:\(Temp.stringTemp(data.tempMax))"
                cell.tempMinLabel.text = "L:\(Temp.stringTemp(data.tempMin))"
            }
     
            return cell
            
        //Hourly forecast
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
            
        //Dayli forecast
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
         
        //Pressure
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
                //cell.valueLabel.text = "\(data.pressure)"
                cell.valueLabel.text = Metrics.strPressure(data.pressure)
            }
     
            return cell
           
        //Humidity
        case 4:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherHumidityCell.idintifier,
                for: indexPath) as? WeatherHumidityCell
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "humidity".uppercased()
            cell.valueLabel.text = "-"
            
            if let data = dataSource {
                //cell.valueLabel.text = "\(data.humidity)"
                cell.valueLabel.text = Metrics.strHumidity(data.humidity)
            }
     
            return cell
           
        //Feels like
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
                //cell.valueLabel.text = "\(data.feelsLike)"
                cell.valueLabel.text = Metrics.strTemp(data.feelsLike, for: true)
            }
     
            return cell
           
        //Wind
        case 6:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherWindCell.idintifier,
                for: indexPath) as? WeatherWindCell
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "wind".uppercased()
            //cell.valueLabel.text = "-"
            
            if let data = dataSource {
                //cell.valueLabel.text = "\(data.wind?.speed ?? 0.0)"
                
                let strWindDeg = Metrics.strWindDeg(data.wind?.deg)
                cell.windDegLabel.text = "Direction: \(strWindDeg)"

                let strWindSpeed = Metrics.strWindSpeedGust(data.wind?.speed)
                cell.windSpeedLabel.text = "Speed: \(strWindSpeed)"
                
                let strWindGust = Metrics.strWindSpeedGust(data.wind?.gust)
                cell.windGustLabel.text = "Gusts: \(strWindGust)"
            }
     
            return cell
         
        //SYS
        case 7:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherSunRiseSetCell.idintifier,
                for: indexPath) as? WeatherSunRiseSetCell
            else {
                assertionFailure()
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "sunset".uppercased()
            //cell.valueLabel.text = "-"
            
            if let data = dataSource {
                //cell.valueLabel.text = "\(data.sys?.sunrise ?? 0)"
                cell.sunsetLabel.text = DateStr.timeFromDateInterval(data.sys?.sunset, like: "HH:mm")
                
                let sunriseTime = DateStr.timeFromDateInterval(data.sys?.sunrise, like: "HH:mm")
                cell.sunriseLabel.text = "Sunrise: \(sunriseTime)"
            }
     
            return cell
         
        //Visibility
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
                //cell.valueLabel.text = "\(data.visibility ?? 0)"
                cell.valueLabel.text = Metrics.strVisibility(data.visibility)
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
            return CGSize(
                width: collectionView.bounds.width - Constant.weatherUIEdgeInset * 2,
                height: Constant.weatherMainCellHeight + 20
            )
            
        case 1:
            return CGSize(
                width: collectionView.bounds.width - Constant.weatherUIEdgeInset * 2,
                height: Constant.weatherHourlyCellHeight
            )
            
        case 2:
            return CGSize(
                width: collectionView.bounds.width - Constant.weatherUIEdgeInset * 2,
                height: Constant.weatherDayliCellHeight
            )
            
        case 3...8:
            return CGSize(
                width: collectionView.bounds.width/2 - Constant.weatherMinimumVerticalSpacing/2 - Constant.weatherUIEdgeInset,
                height: collectionView.bounds.width/2 - Constant.weatherMinimumVerticalSpacing/2 - Constant.weatherUIEdgeInset
            )
            
        default:
            return .zero
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: 0, //Constant.weatherUIEdgeInset,
            left: Constant.weatherUIEdgeInset,
            bottom: Constant.weatherUIEdgeInset,
            right: Constant.weatherUIEdgeInset
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constant.weatherMinimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constant.weatherMinimumVerticalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return .zero
    }
}

