//
//  CityTableViewHeader.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 19.05.2024.
//

import UIKit

class CityTableViewHeader: UIView {
    
    static let idintifier = "CityTableViewHeader"
    
    @IBOutlet weak var cityTextField: UITextField!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton: UITextField!
    var dataSource = [String]()
    
    override func awakeFromNib() {
        //debugPrint("CityTableViewHeader - awakeFromNib")
        
        cityTextField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //selectedButton = cityTextField
    }
    
    func addTransparentView(frames: CGRect) {
        
        let window = self.window
        
        transparentView.frame = window?.frame ?? self.frame
        self.addSubview(transparentView)
        
        tableView.frame = CGRect(
            x: frames.origin.x,
            y: frames.origin.y + frames.height,
            width: frames.width,
            height: 0
        )
        self.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.transparentView.alpha = 0.5
                self.tableView.frame = CGRect(
                    x: frames.origin.x,
                    y: frames.origin.y + frames.height + 5,
                    width: frames.width,
                    height: CGFloat(self.dataSource.count * 50)
                )
            },
            completion: nil
        )
    }
    
    @objc func removeTransparentView() {
        
        let frames = selectedButton.frame
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.transparentView.alpha = 0
                self.tableView.frame = CGRect(
                    x: frames.origin.x,
                    y: frames.origin.y + frames.height,
                    width: frames.width,
                    height: 0
                )
            },
            completion: nil
        )
    }
}

