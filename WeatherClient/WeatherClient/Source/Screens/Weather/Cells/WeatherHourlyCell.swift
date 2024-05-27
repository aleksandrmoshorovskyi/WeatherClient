//
//  WeatherHourlyCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 27.05.2024.
//

import UIKit

class WeatherHourlyCell: UICollectionViewCell {

    static let idintifier = "WeatherHourlyCell"
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        
        self.backgroundColor = Constant.weatherTopCellBackgroundColor
        contentView.backgroundColor = Constant.weatherTopCellContentViewColor
        
        //containerView.backgroundColor = .lightGray
    }
}
