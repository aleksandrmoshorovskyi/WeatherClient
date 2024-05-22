//
//  MainView+CollectionView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import UIKit

// MARK: UICollectionView - DataSource
extension MainView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let dataSource = dataSourceAr {
            return dataSource.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCollectionCell.idintifier,
            for: indexPath) as? MainCollectionCell
        else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        if let data = dataSourceAr {
            let VC = data[indexPath.row]
            VC.view.frame = cell.contentView.frame
            cell.contentView.addSubview(VC.view)
        }
        
        return cell
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCollectionViewCell.idintifier,
            for: indexPath) as? MainCollectionViewCell
        else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        //cell.contentView.backgroundColor = .brown
        //cell.tempLabel?.text = "\(data ?? "- -") ℃"
        
        cell.cityLabel?.text = dataDM?.name

        if let data = dataDM {
            let tempStr = String(format: "%.0f" , data.main.temp)
            cell.tempLabel?.text = "\(tempStr) ℃"
            
            let tempMaxStr = String(format: "%.0f" , data.main.tempMax)
            let tempMinStr = String(format: "%.0f" , data.main.tempMin)
            cell.hlLabel?.text = "H:\(tempMaxStr)℃ L:\(tempMinStr)℃"
        } else {
            cell.tempLabel?.text = "- - ℃"
            cell.hlLabel?.text = ""
        }

        //cell.tempLabel?.text = "\(String(describing: dataDM?.main.temp)) ℃"
        cell.descLabel?.text = dataDM?.weather[0].main
        //cell.hlLabel?.text = ""
        
        /*
        let VC = WeatherViewController()
        
        VC.doSomething(for: indexPath.row)
        
        VC.dataSource = "N - \(indexPath.row)"
        
        if let data = dataDM {
            let tempStr = String(format: "%.0f" , data.main.temp)
            VC.dataSource = "\(tempStr) ℃"
        } else {
            VC.dataSource = "- - ℃"
        }
        
        VC.view.frame = cell.contentView.frame
        //self.addChild(VC)
        cell.contentView.addSubview(VC.view)
         */
        
        if let data = dataSourceAr {
            let VC = data[indexPath.row]
            VC.view.frame = cell.contentView.frame
            cell.contentView.addSubview(VC.view)
        }
        
        return cell
    }
     */
     
}

// MARK: UICollectionViewDelegate
extension MainView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let scrollPosition = scrollView.contentOffset.x / scrollView.bounds.width
        
        mainPageControl.currentPage = scrollPosition.isNaN ? 0 : Int(round(scrollPosition))
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MainView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return .zero
    }
}
