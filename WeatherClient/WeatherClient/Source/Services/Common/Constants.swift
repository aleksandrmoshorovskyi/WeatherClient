//
//  Constants.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 10.05.2024.
//

import UIKit

// MARK: - Constant
enum Constant {
    
    //dt
    static let updateDelay: Int32 = 600 //10 minutes
    static let storagePeriod: Int32 = 86400 //24 hours
    
    //layouts
    static let tabBarHeight: CGFloat = 80.0 //83.0
    static let buttonHeight: CGFloat = 35.0
    static let buttonWidth: CGFloat = 51.0
    static let lineHeight: CGFloat = 1.0
    static let labelSideOffset: CGFloat = 20.0
    static let labelTopOffset: CGFloat = 10.0
    
    //UI
    static let mainColor: UIColor = .systemCyan
    static let colorForDebug: UIColor = .red
    
    ///main view
    static let mainViewColor: UIColor = Constant.mainColor
    static let mainCollectionViewColor: UIColor = .clear
    static let mainTabbarColor: UIColor = .clear
    //static let customBarLineViewColor: UIColor = .darkGray
    static let customBarLineViewColor: UIColor = .lightGray
    
    ///setting table view
    static let cityTableViewCellColor: UIColor = Constant.mainColor
    static let cityCellBackgroundColor: UIColor = .clear
    static let cityCellContentViewColor: UIColor = .clear
    
    ///weather view
    static let weatherViewColor: UIColor = .clear
    static let weatherCollectionViewColor: UIColor = .clear
    static let weatherTopCellBackgroundColor: UIColor = .clear
    static let weatherTopCellContentViewColor: UIColor = .clear
    static let weatherTopCellContainerViewColor: UIColor = .clear
}
