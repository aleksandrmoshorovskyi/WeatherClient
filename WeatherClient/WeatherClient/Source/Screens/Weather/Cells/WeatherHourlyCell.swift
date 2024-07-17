//
//  WeatherHourlyCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 27.05.2024.
//

import UIKit

class WeatherHourlyCell: UICollectionViewCell {

    //static let idintifier = "WeatherHourlyCell"
    
    var dataSource: [HourlyForecast]!
    
    @IBOutlet weak var containerView: UIView!
    //@IBOutlet weak var collectionView: UICollectionView!
    
    var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        
        self.backgroundColor = Constant.weatherTopCellBackgroundColor
        contentView.backgroundColor = Constant.weatherTopCellContentViewColor
        
        //containerView.backgroundColor = .lightGray
        
        // MARK: collectionView setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
    
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = Constant.mainCollectionViewColor
        collectionView.isPagingEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            UINib(nibName: WeatherHourlyDetailCell.idintifier, bundle: nil),
            forCellWithReuseIdentifier: WeatherHourlyDetailCell.idintifier)
    }
}
