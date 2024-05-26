//
//  CityTableViewCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    static let idintifier = "CityTableViewCell"
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        
        self.backgroundColor = Constant.cityCellBackgroundColor
        contentView.backgroundColor = Constant.cityCellContentViewColor
        
        mainView.backgroundColor = Constant.cityTableViewCellColor
    }
}
