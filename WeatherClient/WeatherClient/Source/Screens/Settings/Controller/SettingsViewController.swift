//
//  SettingsViewController.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    weak var delegate: SettingsViewControllerDelegate?
    
    var model: SettingsModelProtocol!
    
    var contentView: SettingsViewProtocol!
    
    var settingsBarButton: UIBarButtonItem!
    
    var serchDataSource: [SearchDataModel] = []
    var resultsTableController: UITableViewController!
    
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
        
        //setupInitialState
        setupInitialState()
        model.loadData()
        
        setupUI()
        
        if let nc = navigationController {
            nc.navigationBar.prefersLargeTitles = true
            nc.navigationBar.tintColor = .white
            
            let nsAttributedString = [NSAttributedString.Key.foregroundColor: UIColor.white]
            nc.navigationBar.titleTextAttributes = nsAttributedString
            nc.navigationBar.largeTitleTextAttributes = nsAttributedString
            
            navigationItem.hidesBackButton = true
            navigationItem.title = "Weather"
            navigationItem.rightBarButtonItem = settingsBarButton
    
            // MARK: resultsTableController
            resultsTableController = ResultsTableController()
            resultsTableController.tableView.delegate = self
            resultsTableController.tableView.dataSource = self
            
            let searchController = UISearchController(searchResultsController: resultsTableController)
            searchController.delegate = self
            searchController.searchResultsUpdater = self
            //searchController.searchBar.autocapitalizationType = .none
            searchController.searchBar.delegate = self // Monitor when the search button is tapped.
            
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false

            definesPresentationContext = true
            
            //setupDataSource()
            
            navigationItem.searchController?.searchBar.searchTextField.textColor = .white
            
            let colorForPlaceholder = UIColor.systemGray
            navigationItem.searchController?.searchBar.searchTextField.leftView?.tintColor = colorForPlaceholder
            let placeholderColor = NSAttributedString(
                string: "Search for a city",
                attributes: [NSAttributedString.Key.foregroundColor: colorForPlaceholder]
            )
            navigationItem.searchController?.searchBar.searchTextField.attributedPlaceholder = placeholderColor
        }
    }
    
    private func setupInitialState() {
        let settingsModel = SettingsModel(delegate: self)
        model = settingsModel
    }
    
    private func setupUI() {
        
        /*
        settingsBarButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingsBarButtonDidTap)
        )
         */
        
        let settingsMenu = generatePullDownMenu()

        settingsBarButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle"),
            menu: settingsMenu
        )
    }
    
    @objc func editButtonDidTap() {
        //contentView.tableView.isEditing = !contentView.tableView.isEditing
        //btn.title = contentView.tableView.isEditing ? "Done" : "Edit"
    }
    
    private func generatePullDownMenu() -> UIMenu {
        
        let defaults = UserDefaults.standard
        let tempUnit = defaults.integer(forKey: "tempUnit")
        
        let editList = UIAction(
            title: "Edit List",
            image: UIImage(systemName: "pencil")
        ) { _ in
            self.settingsBarButtonDidTap()
        }
        
        let notificatBtn = UIAction(
            title: "Notifications",
            image: UIImage(systemName: "bell.badge")
        ) { _ in
            //action
        }
        
        let celsiusItem = UIAction(
            title: "Celsius",
            image: UIImage(named: "celsiusIcon"),
            state: tempUnit == 0 ? .on : .off
        ) {_ in
            self.celsiusItemDidTap()
        }
        
        let fahrenheitItem = UIAction(
            title: "Fahrenheit",
            image: UIImage(named: "tempFahrenheitIcon"),
            state: tempUnit == 1 ? .on : .off
        ) {_ in
            self.fahrenheitItemDidTap()
        }
        
        let unitsBtn = UIAction(
            title: "Units",
            image: UIImage(systemName: "chart.bar")
        ) {_ in
            //action
        }
        
        let clearCash = UIAction(
            title: "Clear cash",
            image: UIImage(systemName: "trash.fill"),
            attributes: [.destructive]
        ) {_ in
            //clear cash
        }
        
        let subEditMenu = UIMenu(
            options: .displayInline,
            children: [editList, notificatBtn]
        )
        
        let degreesMenu = UIMenu(
            options: .displayInline,
            children: [celsiusItem, fahrenheitItem]
        )
        
        let unitsMenu = UIMenu(
            options: .displayInline,
            children: [unitsBtn]
        )
        
        let subCashMenu = UIMenu(
            options: .displayInline,
            children: [clearCash]
        )
        
        let settingsMenu = UIMenu(
            children: [subEditMenu,
                       degreesMenu,
                       unitsMenu,
                       subCashMenu]
        )
        
        return settingsMenu
    }
    
    private func celsiusItemDidTap() {
        // 0 - Celsius
        // 1 - Fahrenheit
        let defaults = UserDefaults.standard
        let tempUnit = defaults.integer(forKey: "tempUnit")
        
        defaults.set(tempUnit == 1 ? 0 : 0, forKey: "tempUnit")
        self.settingsBarButton.menu = generatePullDownMenu()
        delegate?.dataDidChange()
        model.loadData()
    }
    
    private func fahrenheitItemDidTap() {
        // 0 - Celsius
        // 1 - Fahrenheit
        let defaults = UserDefaults.standard
        let tempUnit = defaults.integer(forKey: "tempUnit")
        
        defaults.set(tempUnit == 0 ? 1 : 1, forKey: "tempUnit")
        self.settingsBarButton.menu = generatePullDownMenu()
        delegate?.dataDidChange()
        model.loadData()
    }
}

extension SettingsViewController: UITableViewDelegate {
    
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return serchDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        var strCityNameState = ""
        
        strCityNameState.append(serchDataSource[indexPath.row].name)
        
        if let state = serchDataSource[indexPath.row].state {
            strCityNameState.append(", ")
            strCityNameState.append(state)
        }
        
        if let country = serchDataSource[indexPath.row].country {
            strCityNameState.append(", ")
            strCityNameState.append(country)
        }
        
        cell.textLabel?.text = strCityNameState
         
        return cell
    }
}

extension SettingsViewController: UISearchControllerDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let weatherViewController = WeatherViewController()
        weatherViewController.delegate = self
        
        let serchedCity = serchDataSource[indexPath.row]
        
        let dataCity = CityDataModel(
            name: serchedCity.name,
            latitude: serchedCity.latitude,
            longitude: serchedCity.longitude,
            state: serchedCity.state,
            country: serchedCity.country
        )
        
        weatherViewController.currentCity = dataCity
        weatherViewController.isPresent = true
        weatherViewController.loadWeatherData(for: dataCity)
        
        self.present(weatherViewController, animated: true)
    }
}

extension SettingsViewController: WeatherViewControllerDelegate {
    
    func cityDidAdd() {
        navigationItem.searchController?.searchBar.searchTextField.text = ""
        navigationItem.searchController?.dismiss(animated: true)
        model.loadData()
        
        delegate?.dataDidChange()
    }
}

extension SettingsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //searchController.searchBar.text! = ""
        
        let searchString = searchController.searchBar.text!
        
        debugPrint("searchString - \(searchString)")
        
        if searchString.count >= 3 {
            model.loadSearchData(for: searchString)
        }
    }
}

extension SettingsViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = ""
    }
}
