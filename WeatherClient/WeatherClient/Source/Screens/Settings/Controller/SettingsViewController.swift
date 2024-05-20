//
//  SettingsViewController.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import UIKit

class SettingsViewController: UIViewController, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //code
    }
    
    var model: SettingsModelProtocol!
    
    var contentView: SettingsViewProtocol!
    
    var settingsBarButton: UIBarButtonItem!
    
    @objc func settingsBarButtonDidTap() {
        contentView.settingsBarButtonAction()
    }
    
    override func loadView() {
        
        //setupInitialState()
        //model.loadData()
        
        let settingsView = SettingsView()
        //settingsView.backgroundColor = .red
        settingsView.delegate = self
        
        contentView = settingsView
        
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialState()
        model.loadData()
        
        settingsBarButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingsBarButtonDidTap)
        )
        
        if let nc = navigationController {
            navigationItem.rightBarButtonItem = settingsBarButton
            navigationItem.hidesBackButton = true
            navigationItem.title = "Weather"
            
            nc.navigationBar.prefersLargeTitles = true
            nc.navigationBar.tintColor = .white
            
            let nsAttributedString = [NSAttributedString.Key.foregroundColor: UIColor.white]
            nc.navigationBar.titleTextAttributes = nsAttributedString
            nc.navigationBar.largeTitleTextAttributes = nsAttributedString
            
//            var segment = UISegmentedControl()
//            segment = UISegmentedControl(items: ["1", "2"])
//            segment.selectedSegmentIndex = 0
//            segment.addTarget(self, action: #selector(settingsBarButtonDidTap), for: .valueChanged)
//            self.navigationItem.titleView = segment
            
            let search = UISearchController(searchResultsController: nil)
            search.searchResultsUpdater = self
            //search.obscuresBackgroundDuringPresentation = false
            search.searchBar.placeholder = "Search for a city"
            //search.searchBar.tintColor = .white
            //search.searchBar.barTintColor = .cyan
            //search.searchBar.searchTextField.textColor = .white
            
            navigationItem.searchController = search
            
            //navigationItem.searchController?.isActive = true
            navigationItem.hidesSearchBarWhenScrolling = false
            //navigationItem.searchController?.searchBar.barStyle = .default
            //navigationItem.searchController?.searchBar.searchTextField.tintColor = .white
            navigationItem.searchController?.searchBar.searchTextField.textColor = .white
            
            
            let colorForPlaceholder = UIColor.systemGray
            
            navigationItem.searchController?.searchBar.tintColor = .blue
            
            navigationItem.searchController?.searchBar.searchTextField.leftView?.tintColor = colorForPlaceholder
            
            //let placeholderColor =  NSAttributedString(string: searchTextField.placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor : UIColor.red])
            
            let placeholderColor = NSAttributedString(
                string: "Search for a city",
                attributes: [NSAttributedString.Key.foregroundColor: colorForPlaceholder]
            )
            
            navigationItem.searchController?.searchBar.searchTextField.attributedPlaceholder = placeholderColor
            
            //var searchField = navigationItem.searchController?.searchBar.searchTextField
            
            //[searchField, setValue:[UIColor blueColor] forKeyPath:@"_placeholderLabel.textColor"]
            
            //navigationItem.searchController?.isActive = true
            //navigationItem.searchController?.searchBar.isEnabled = true
            //navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        }
    }
    
    private func setupInitialState() {
        
        let settingsModel = SettingsModel(delegate: self)
        
        model = settingsModel
    }
    
    @objc func editButtonDidTap() {
        //contentView.tableView.isEditing = !contentView.tableView.isEditing
        //btn.title = contentView.tableView.isEditing ? "Done" : "Edit"
    }
}
