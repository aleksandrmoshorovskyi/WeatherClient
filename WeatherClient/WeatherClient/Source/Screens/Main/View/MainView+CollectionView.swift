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
            //debugPrint("i - \(indexPath.row), VCrfame - \(VC.view.frame), cellFrame -  \(cell.contentView.frame)")
            VC.view.frame = cell.contentView.frame
            //debugPrint("i - \(indexPath.row), VCrfame - \(VC.view.frame), cellFrame -  \(cell.contentView.frame)")
            cell.contentView.addSubview(VC.view)
        }
        
        return cell
    }
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
        
        //return collectionView.bounds.size
        //return collectionView.frame.size
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        //return CGSize(width: 393.0, height: 400.0)
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
