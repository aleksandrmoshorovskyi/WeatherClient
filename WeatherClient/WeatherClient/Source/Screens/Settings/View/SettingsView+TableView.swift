//
//  SettingsView+TableView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import UIKit

extension SettingsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesWithWeather == nil ? 0 : citiesWithWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.idintifier) as? CityTableViewCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        cell.cityNameLabel?.text = ""
        cell.weatherDescLabel?.text = ""
        cell.tempLabel?.text = ""
        
        if let dataSource = citiesWithWeather {
            
            let city = dataSource[indexPath.row].city
            cell.cityNameLabel?.text = city.name
            
            if let weather = dataSource[indexPath.row].weather {
                cell.weatherDescLabel?.text = weather.desc
                let tempStr = String(format: "%.0f" , weather.temp)
                cell.tempLabel?.text = "\(tempStr) ℃"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            delegate?.cityRowDeleteAt(citiesWithWeather[indexPath.row].city)
            citiesWithWeather.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        delegate?.swapAt(
            citiesWithWeather[sourceIndexPath.row].city,
            citiesWithWeather[destinationIndexPath.row].city
        )
        citiesWithWeather.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        tableView.reloadData()
    }
}

extension SettingsView: UITableViewDelegate {
    
    /*
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 100.0
    }
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.cityRowDidTapAt(indexPath)
    }
}
