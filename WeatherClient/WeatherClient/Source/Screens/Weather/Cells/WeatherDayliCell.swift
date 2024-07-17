//
//  WeatherDayliCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import UIKit

class WeatherDayliCell: WeatherBaseCell {
    
    var dataSource: [DayliForecast]!
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        //tableView setup
        tableView = UITableView()
        tableView.backgroundColor = .clear
        
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            WeatherDayliTableViewCell.self,
            forCellReuseIdentifier: WeatherDayliTableViewCell.idintifier
        )
    }
    
    func setupLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //contentView.addSubview(tableView) //.alpha = 0.5
        addSubview(tableView) //.alpha = 1
        
        NSLayoutConstraint.activate([
            // tableView constraints
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .zero),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: .zero),
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .zero),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: .zero)
        ])
    }
}
