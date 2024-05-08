//
//  MainViewController.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 08.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    override func loadView() {
        
        let mainView = UIView(frame: .zero)
        mainView.backgroundColor = .red
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
