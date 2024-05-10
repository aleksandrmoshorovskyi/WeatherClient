//
//  MainView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import UIKit

class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    var data: String!
    var dataDM: DMWeatherInfo!
    
    var customTabBarView: UIView!
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
        
        /*
        collectionView.register(
            MainCollectionViewCell.self,
            forCellWithReuseIdentifier: MainCollectionViewCell.idintifier
        )
         */
        
        collectionView.register(
            UINib(nibName: MainCollectionViewCell.idintifier, bundle: nil),
            forCellWithReuseIdentifier: MainCollectionViewCell.idintifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        // MARK: self setup
        backgroundColor = .red
        
        // MARK: collectionView setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
    
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .darkGray
        collectionView.isPagingEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // MARK: customTabBarView setup
        customTabBarView = UIView()
        customTabBarView.backgroundColor = .systemTeal
    }
    
    func setupLayout() {
        
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(customTabBarView)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            // MARK: customTabBarView constraints
            customTabBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            customTabBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            customTabBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .zero),
            customTabBarView.heightAnchor.constraint(equalToConstant: Constant.tabBarHeight),
            
            // MARK: collectionView constraints
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: customTabBarView.topAnchor, constant: .zero)
        ])
    }
}
