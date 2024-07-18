//
//  UICollectionViewCell+Idintifier.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import UIKit

extension UICollectionViewCell {
    
    static var idintifier: String {
        
        get {
            return String(describing: self)
        }
    }
}
