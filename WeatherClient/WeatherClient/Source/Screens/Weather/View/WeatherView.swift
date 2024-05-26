//
//  WeatherView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import UIKit

class WeatherView: UIView {
    
    weak var delegate: WeatherViewDelegate?
    
    //data
    var dataSource: WeatherDataModel!
    //var currentCity: String!
    var currentCity: CityDataModel!
    
    //UI
    var collectionView: UICollectionView!
    
    var cancelButton: UIButton!
    var addButton: UIButton!
    
    @objc func cancelButtonDidTap() {
        delegate?.cancelButtonDidTap()
    }
    
    @objc func addButtonDidTap() {
        delegate?.addButtonDidTap()
    }

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
        //backgroundColor = .clear
        backgroundColor = Constant.weatherViewColor
        
        // MARK: collectionView setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
    
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        //collectionView.showsHorizontalScrollIndicator = false
        //collectionView.backgroundColor = .clear
        collectionView.backgroundColor = Constant.weatherCollectionViewColor
        //collectionView.isPagingEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //it's almost work
        collectionView.contentInsetAdjustmentBehavior = .never
        //https://stackoverflow.com/questions/62668158/uicollectionviewcell-doesnt-fill-the-screen
        
        // MARK: mapButton setup
        cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        //cancelButton.backgroundColor = .red
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        cancelButton.isHidden = true
        
        // MARK: addButton setup
        addButton = UIButton()
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        //addButton.backgroundColor = .red
        addButton.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        addButton.isHidden = true
    }
    
    func setupLayout() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        addSubview(cancelButton)
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            // collectionView constraints
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            //collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60.0),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .zero),
             
            //cancelButton
            cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.labelSideOffset),
            cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.labelTopOffset),
            
            //addButton
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constant.labelSideOffset),
            addButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.labelTopOffset)
        ])
    }
    
//    func setupButtons() {
//        cancelButton.isHidden = false
//        addButton.isHidden = false
//    }
}
