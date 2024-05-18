//
//  WeatherView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import UIKit

class WeatherView: UIView {
    
    weak var delegate: WeatherViewDelegate?
    
    var dataSource: Weather!
    var currentCity: String!
    
    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
        
        collectionView.register(
            UINib(nibName: WeatherMainCell.idintifier, bundle: nil),
            forCellWithReuseIdentifier: WeatherMainCell.idintifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        // MARK: self setup
        backgroundColor = .clear
        
        // MARK: collectionView setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
    
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        //collectionView.isPagingEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupLayout() {
        
        // MARK: collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            // MARK: citiesTableView constraints
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60.0),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .zero)
        ])
    }
}
