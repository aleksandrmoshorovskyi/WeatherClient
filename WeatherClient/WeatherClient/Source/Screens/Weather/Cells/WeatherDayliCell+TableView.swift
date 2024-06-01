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
            cellCount = 5
        }
        
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDayliTableViewCell.idintifier) as? WeatherDayliTableViewCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
         
        //let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = Constant.baseCellTextColor
        
        if let data = dataSource {
            cell.dayLabel.text = "    \(data[indexPath.row].day)"
            cell.iconLabel.text = Icon.getIconByCode(data[indexPath.row].icon)
            //cell.tempMinLabel.text = Metrics.strTemp(data[indexPath.row].tempMin)
            //cell.tempMaxLabel.text = Metrics.strTemp(data[indexPath.row].tempMax)
            cell.tempMinLabel.text = data[indexPath.row].tempMin
            cell.tempMaxLabel.text = data[indexPath.row].tempMax
        }
        
        return cell
    }
}

//MARK: UITableViewDelegate
extension WeatherDayliCell: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44.0
    }
}

