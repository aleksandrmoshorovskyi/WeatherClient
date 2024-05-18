//
//  SettingsViewDelegate.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import Foundation

protocol SettingsViewDelegate: AnyObject {
    
    //func cityDidTap()
    //func cityListButtonDidTap()
    
    func cityRowDidTapAt(_ indexPath: IndexPath)
}

