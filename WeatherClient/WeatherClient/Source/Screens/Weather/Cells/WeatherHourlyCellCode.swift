//
//  WeatherHourlyCellCode.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 31.05.2024.
//

import UIKit

class WeatherHourlyCellCode: WeatherBaseCell {
    
    var dataSource: [HourlyForecast]!
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {

        //collectionView setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
    
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = Constant.mainCollectionViewColor
        //collectionView.isPagingEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        collectionView.register(
//            UINib(nibName: WeatherHourlyDetailCell.idintifier, bundle: nil),
//            forCellWithReuseIdentifier: WeatherHourlyDetailCell.idintifier)
        
        collectionView.register(
            WeatherHourlyDetailCellCode.self,
            forCellWithReuseIdentifier: WeatherHourlyDetailCellCode.idintifier
        )
    }
    
    func setupLayout() {

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            // MARK: collectionView constraints
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: .zero),
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: .zero)
        ])
    }
}
