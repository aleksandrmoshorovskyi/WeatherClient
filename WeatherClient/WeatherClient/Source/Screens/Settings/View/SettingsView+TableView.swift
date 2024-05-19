//
//  SettingsView+TableView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 18.05.2024.
//

import UIKit

extension SettingsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Weather"
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        
////        if editingStyle == .delete {
////            //model.items.remove(at: indexPath.row)
////            tableView.deleteRows(at: [indexPath], with: .automatic)
////        }
//    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        //model.items.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        //tableView.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        
//        return true
//    }
//    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        
//        return true
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.idintifier) as? CityTableViewCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.cityNameLabel?.text = ""
        cell.weatherDescLabel?.text = ""
        cell.tempLabel?.text = ""
        
        if let dataSource = citiesDataSource {
            let city = dataSource[indexPath.row]
            cell.cityNameLabel?.text = city.name
            if let weather = dataSource[indexPath.row].weather {
                cell.weatherDescLabel?.text = weather.desc
                let tempStr = String(format: "%.0f" , weather.temp)
                cell.tempLabel?.text = "\(tempStr) ℃"
            }
        }
        
        return cell
    }
}

extension SettingsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.cityRowDidTapAt(indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let nibHeader = Bundle.main.loadNibNamed(CityTableViewHeader.idintifier, owner: self)
        let headerView = nibHeader?.first as! UIView
        
        return headerView
    }
}
