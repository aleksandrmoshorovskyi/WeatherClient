//
//  SettingsView.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import UIKit

class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate?
    
    //data
    var citiesWithWeather: [CityWeatherDataModel]!
    
    //UI
    var citiesTableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
        
        let nibCell = UINib(nibName: CityTableViewCell.idintifier, bundle: nil)
        citiesTableView.register(nibCell, forCellReuseIdentifier: CityTableViewCell.idintifier)
        
        //let nibHeader = UINib(nibName: CityTableViewHeader.idintifier, bundle: nil)
        //citiesTableView.register(nibHeader, forHeaderFooterViewReuseIdentifier: CityTableViewHeader.idintifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        // MARK: self setup
        backgroundColor = .black
        
        // MARK: weatherTableView setup
        citiesTableView = UITableView()
        citiesTableView.backgroundColor = .clear
        
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
    }
    
    func setupLayout() {
        
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(citiesTableView)
        
        NSLayoutConstraint.activate([
            // MARK: citiesTableView constraints
            citiesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            citiesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            citiesTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero),
            citiesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .zero),
        ])
    }
 
}
