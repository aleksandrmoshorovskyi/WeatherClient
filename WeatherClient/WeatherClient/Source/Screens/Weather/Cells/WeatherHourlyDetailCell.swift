//
//  WeatherHourlyDetailCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 31.05.2024.
//

import UIKit

class WeatherHourlyDetailCell: UICollectionViewCell {
    
    static let idintifier = "WeatherHourlyDetailCell"
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        
        self.backgroundColor = Constant.weatherTopCellBackgroundColor
        contentView.backgroundColor = Constant.weatherTopCellContentViewColor
        
        containerView.backgroundColor = Constant.weatherTopCellContainerViewColor
    }
}
