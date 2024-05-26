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
    //var settingsButton: UIButton!
    
    /*
    @objc func settingsButtonDidTap() {
        citiesTableView.isEditing = !citiesTableView.isEditing
        setupSettingsButton()
    }
     */

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
        
        /*
        citiesTableView.register(
            CityTableViewCell.self,
            forCellReuseIdentifier: CityTableViewCell.idintifier
        )
         */
        
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
        
        // MARK: settings button setup
        /*
        settingsButton = UIButton()
        setupSettingsButton()
        settingsButton.tintColor = .white
        settingsButton.addTarget(self, action: #selector(settingsButtonDidTap), for: .touchUpInside)
         */
    }
    
    func setupLayout() {
        
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        //settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(citiesTableView)
        //addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            // MARK: citiesTableView constraints
            citiesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            citiesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            citiesTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero),
            citiesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .zero),
            
            // settingsButton constraints
            //settingsButton.trailingAnchor.constraint(equalTo: citiesTableView.trailingAnchor, constant: -Constant.labelSideOffset),
            //settingsButton.topAnchor.constraint(equalTo: citiesTableView.topAnchor, constant: 60.0)
            //settingsButton.heightAnchor.constraint(equalToConstant: Constant.standardButtonHeight)
        ])
    }
    
    /*
    func setupSettingsButton() {
        
        if citiesTableView.isEditing {
            settingsButton.setTitle("Done", for: .normal)
            settingsButton.setImage(nil, for: .normal)
        } else {
            settingsButton.setTitle(nil, for: .normal)
            settingsButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        }
    }
     */
}
