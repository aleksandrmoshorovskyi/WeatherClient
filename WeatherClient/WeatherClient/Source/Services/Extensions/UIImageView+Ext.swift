//
//  UIImageView+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 31.05.2024.
//

import UIKit

extension UIImageView {

    func load(url: URL) {
        
        /*
         Thread Performance Checker: Thread running at User-initiated quality-of-service class waiting on a lower QoS thread running at Default quality-of-service class. Investigate ways to avoid priority inversions
         */
        
        //DispatchQueue.global().async { [weak self] in
        DispatchQueue.global(qos: .default).async { [weak self] in
            
            if let data = try? Data(contentsOf: url) {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                    
                }
            }
        }
    }
}
