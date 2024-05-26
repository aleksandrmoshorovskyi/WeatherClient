//
//  CityTableViewHeader+Ext.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 19.05.2024.
//

import UIKit

// MARK: CityTableViewHeader - UITextFieldDelegate
extension CityTableViewHeader: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        cityTextField.endEditing(true)
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        dataSource = ["Apple", "Mango", "Orange"]
        selectedButton = cityTextField
        addTransparentView(frames: cityTextField.frame)
    }
}

// MARK: CityTableViewHeader - UITableViewDataSource
extension CityTableViewHeader: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = dataSource[indexPath.row]
        
        return cell
    }
}

// MARK: CityTableViewHeader - UITableViewDelegate
extension CityTableViewHeader: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //selectedButton.setTitle(dataSource[indexPath.row], for:  .normal)
        
        removeTransparentView()
    }
}
