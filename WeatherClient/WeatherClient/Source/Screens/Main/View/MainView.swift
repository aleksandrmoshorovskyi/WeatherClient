//
//  MainView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import UIKit

class MainView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCollectionViewCell.idintifier,
            for: indexPath) as? MainCollectionViewCell
        else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        cell.contentView.backgroundColor = .brown
        cell.tempLabel?.text = "\(data ?? "") ℃"
        cell.tempLabel?.text = "fff"
        
        return cell
    }
    
    
    weak var delegate: MainViewDelegate?
    
    var customTabBarView: UIView!
    var collectionView: UICollectionView!
    
    var data: String!
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
        
        collectionView.register(
            MainCollectionViewCell.self,
            forCellWithReuseIdentifier: MainCollectionViewCell.idintifier
        )
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
        collectionView.backgroundColor = .systemBackground
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // MARK: customTabBarView setup
        customTabBarView = UIView()
        customTabBarView.backgroundColor = .systemTeal
        
        // MARK: label setup
        label.textColor = .white
        label.font = .systemFont(ofSize: 54.0)
        label.textAlignment = .center
    }
    
    func setupLayout() {
        
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(customTabBarView)
        addSubview(collectionView)
        addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.labelSideOffset).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.labelSideOffset).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: Constant.labelSideOffset).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.labelSideOffset).isActive = true
        
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
