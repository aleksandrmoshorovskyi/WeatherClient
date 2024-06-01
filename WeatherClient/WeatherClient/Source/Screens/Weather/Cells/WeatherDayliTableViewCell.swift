//
//  WeatherDayliTableViewCell.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 01.06.2024.
//

import UIKit

class WeatherDayliTableViewCell: UITableViewCell {
  
    static let idintifier = "WeatherDayliTableViewCell"
    
    var stackView: UIStackView!
    
    var spacingLabel: UILabel!
    var spacingLabel2: UILabel!
    var spacingLabel3: UILabel!
    var spacingLabel4: UILabel!
    
    var spacingLongLabel: UILabel!
    
    var dayLabel: UILabel!
    //var iconImage: UIImageView!
    var iconLabel: UILabel!
    
    var tempMinLabel: UILabel!
    var tempMaxLabel: UILabel!
    
    //var detailLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        
//        setupUI()
//        setupLayout()
//    }
    
    func setupUI() {
        
        self.backgroundColor = Constant.weatherTopCellBackgroundColor
        contentView.backgroundColor = Constant.weatherTopCellContentViewColor
        
        //containerView.backgroundColor = Constant.weatherTopCellContainerViewColor
        
        //hourLabel
        dayLabel = UILabel()
        dayLabel.textColor = Constant.baseCellTextColor
        
        //spacingLabel
        spacingLabel = UILabel()
        spacingLabel.textColor = Constant.baseCellTextColor
        //spacingLabel.font = Constant.baseCellTextFont
        spacingLabel.text = " "
        
        //spacingLabel2
        spacingLabel2 = UILabel()
        spacingLabel2.textColor = Constant.baseCellTextColor
        //spacingLabel.font = Constant.baseCellTextFont
        spacingLabel2.text = " "
        
        //spacingLabel3
        spacingLabel3 = UILabel()
        spacingLabel3.textColor = Constant.baseCellTextColor
        //spacingLabel.font = Constant.baseCellTextFont
        spacingLabel3.text = " "
        
        //spacingLabel4
        spacingLabel4 = UILabel()
        spacingLabel4.textColor = Constant.baseCellTextColor
        //spacingLabel.font = Constant.baseCellTextFont
        spacingLabel4.text = " "
        
        //spacingLongLabel
        spacingLongLabel = UILabel()
        spacingLongLabel.textColor = Constant.baseCellTextColor
        //spacingLabel.font = Constant.baseCellTextFont
        spacingLongLabel.text = "-----"
        
        //hourLabel
        //iconImage = UIImageView()
        //iconImage.contentMode = .scaleAspectFit //small pic
        //iconImage.contentMode = .scaleAspectFill //big pic
        //iconImage.tintColor = .systemYellow
        
        //iconLabel
        iconLabel = UILabel()
        
        //detailLabel
        //detailLabel = UILabel()
        //detailLabel.textColor = Constant.baseCellTextColor
        //detailLabel.font = UIFont.systemFont(ofSize: 20)
        
        //tempMinLabel
        tempMinLabel = UILabel()
        tempMinLabel.textColor = Constant.baseCellTextColor
        
        //tempMaxLabel
        tempMaxLabel = UILabel()
        tempMaxLabel.textColor = Constant.baseCellTextColor
        
        // MARK: - stackView config
        stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        //view.addSubview(stackView)
        
        //stackView.addArrangedSubview(spacingLabel)
        stackView.addArrangedSubview(dayLabel)
        //stackView.addArrangedSubview(spacingLabel2)
        stackView.addArrangedSubview(iconLabel)
        //stackView.addArrangedSubview(spacingLabel3)
        stackView.addArrangedSubview(tempMinLabel)
        stackView.addArrangedSubview(spacingLongLabel)
        stackView.addArrangedSubview(tempMaxLabel)
        //stackView.addArrangedSubview(spacingLabel4)
    }
    
    func setupLayout() {

        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // MARK: collectionView constraints
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .zero)
        ])
    }
}
