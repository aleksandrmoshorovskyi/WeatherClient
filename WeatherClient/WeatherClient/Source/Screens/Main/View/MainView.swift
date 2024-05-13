//
//  MainView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import UIKit

class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    
    //test data {
    var data: String!
    var dataDM: DMWeatherInfo!
    //} test data
    
    var customTabBarView: UIView!
    var collectionView: UICollectionView!
    
    var mapButton: UIButton!
    var cityListButton: UIButton!
    var mainPageControl: UIPageControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
        
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
        
        // MARK: mainPageControl setup
        mainPageControl = UIPageControl()
        mainPageControl.numberOfPages = 3
        mainPageControl.currentPage = 0
        mainPageControl.backgroundColor = .red
        
        // MARK: mapButton setup
        mapButton = UIButton()
        mapButton.setImage(UIImage(systemName: "map"), for: .normal)
        mapButton.tintColor = .white
        mapButton.backgroundColor = .red
        
        // MARK: cityListButton setup
        cityListButton = UIButton()
        cityListButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        cityListButton.tintColor = .white
        cityListButton.backgroundColor = .red
    }
    
    func setupLayout() {
        
        // MARK: main views
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(customTabBarView)
        addSubview(collectionView)
        
        // MARK: customTabBarView views
        mainPageControl.translatesAutoresizingMaskIntoConstraints = false
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        cityListButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainPageControl)
        addSubview(mapButton)
        addSubview(cityListButton)
        
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
            collectionView.bottomAnchor.constraint(equalTo: customTabBarView.topAnchor, constant: .zero),
            
            // MARK: mainPageControl constraints
            mainPageControl.centerXAnchor.constraint(equalTo: customTabBarView.centerXAnchor),
            mainPageControl.topAnchor.constraint(equalTo: customTabBarView.topAnchor, constant: Constant.labelTopOffset),
            
            // MARK: mapButton constraints
            mapButton.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor, constant: Constant.labelSideOffset),
            mapButton.trailingAnchor.constraint(lessThanOrEqualTo: mainPageControl.leadingAnchor, constant: -Constant.labelSideOffset),
            mapButton.topAnchor.constraint(equalTo: customTabBarView.topAnchor, constant: Constant.labelTopOffset),
            mapButton.heightAnchor.constraint(equalToConstant: Constant.standardButtonHeight),
            
            // MARK: cityListButton constraints
            cityListButton.leadingAnchor.constraint(greaterThanOrEqualTo: mainPageControl.trailingAnchor, constant: Constant.labelSideOffset),
            cityListButton.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor, constant: -Constant.labelSideOffset),
            cityListButton.topAnchor.constraint(equalTo: customTabBarView.topAnchor, constant: Constant.labelTopOffset),
            cityListButton.heightAnchor.constraint(equalToConstant: Constant.standardButtonHeight)
        ])
    }
}
