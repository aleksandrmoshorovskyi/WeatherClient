//
//  WeatherDayliCell+TableView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import UIKit

//MARK: UITableViewDataSource
extension WeatherDayliCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var cellCount = 0
        
        if let data = dataSource {
            cellCount = data.count
        }
        
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.idintifier) as? CityTableViewCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
         */
         
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        
        if let data = dataSource {
            cell.textLabel?.text = data[indexPath.row].day
        }
        
        return cell
    }
}

//MARK: UITableViewDelegate
extension WeatherDayliCell: UITableViewDelegate {

}

