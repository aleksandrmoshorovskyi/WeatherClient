//
//  WeatherMainCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import UIKit

class WeatherMainCell: UICollectionViewCell {
    
    //static let idintifier = "WeatherMainCell"
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    
    override func awakeFromNib() {
        
        self.backgroundColor = Constant.weatherTopCellBackgroundColor
        contentView.backgroundColor = Constant.weatherTopCellContentViewColor
        
        containerView.backgroundColor = Constant.weatherTopCellContainerViewColor
    }
}
