//
//  MainCollectionViewCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    //static let idintifier = "MainCollectionViewCell"
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var hlLabel: UILabel!
    
    override func awakeFromNib() {
        
    }
}
