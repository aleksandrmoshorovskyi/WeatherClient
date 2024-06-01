//
//  WeatherBaseCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import UIKit

class WeatherBaseCell: UICollectionViewCell {
    
    var containerView: UIView!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBaseUI()
        setupBaseLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBaseUI() {
        
        self.backgroundColor = Constant.baseCellBackgroundColor
        
        // MARK: contentView setup
        contentView.layer.cornerRadius = Constant.weatherCellCornerRadius
        contentView.backgroundColor = Constant.contentViewColor
        contentView.alpha = Constant.contentViewAlpha
        
        // MARK: titleLabel setup
        titleLabel = UILabel()
        
        // MARK: containerView setup
        containerView = UIView()
        containerView.backgroundColor = Constant.containerViewColor
    }
    
    func setupBaseLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        //.alpha = 0.5
        contentView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        
        //.alpha = 1
        //addSubview(titleLabel)
        //addSubview(containerView)
        
        NSLayoutConstraint.activate([
            // MARK: titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .zero),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.titleLabelSideOffset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.titleLabelSideOffset),
            titleLabel.heightAnchor.constraint(equalToConstant: Constant.titleLabelHeight),
            
            // MARK: collectionView constraints
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .zero),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .zero),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .zero),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .zero)
        ])
    }
}
