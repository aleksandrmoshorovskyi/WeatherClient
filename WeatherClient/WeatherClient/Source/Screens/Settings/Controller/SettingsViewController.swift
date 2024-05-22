//
//  SettingsViewController.swift
//  WeatherClient
//
//  Created by Aleksandr Moroshovskyi on 17.05.2024.
//

import UIKit

class SettingsViewController: UIViewController { //, UISearchResultsUpdating
    
    //func updateSearchResults(for searchController: UISearchController) {
        //code
    //}
    
    var model: SettingsModelProtocol!
    
    var contentView: SettingsViewProtocol!
    
    var settingsBarButton: UIBarButtonItem!
    
    var serchDataSource: [Search] = []
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
    
    /*
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
            
            /*
            let sc = UIViewController()
            sc.view.frame = CGRect(x: 0, y: 100, width: 300, height: 300)
            sc.view.backgroundColor = .brown
             */
            
            let resultsTableController = ResultsTableController()
            resultsTableController.tableView.delegate = self
            
            let search = UISearchController(searchResultsController: resultsTableController)
            
            search.showsSearchResultsController = true
            
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
            navigationItem.searchController?.searchBar.searchTextField.leftView?.tintColor = colorForPlaceholder
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
     */
    
    private func setupInitialState() {
        let settingsModel = SettingsModel(delegate: self)
        model = settingsModel
    }
    
    private func setupUI() {
        settingsBarButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingsBarButtonDidTap)
        )
    }
    
    @objc func editButtonDidTap() {
        //contentView.tableView.isEditing = !contentView.tableView.isEditing
        //btn.title = contentView.tableView.isEditing ? "Done" : "Edit"
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
        
        let cityName = serchDataSource[indexPath.row].name
        weatherViewController.currentCity = cityName
        weatherViewController.isPresent = true
        weatherViewController.doSomething(with: cityName)

        self.present(weatherViewController, animated: true)
    }
}

extension SettingsViewController: WeatherViewControllerDelegate {
    
    func controllerDismissed() {
        navigationItem.searchController?.dismiss(animated: true)
        model.loadData()
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
    
}

/*
 func updateSearchResults(for searchController: UISearchController) {
        // Update the filtered array based on the search text.
        let searchResults = products


        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString =
            searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]


        // Build all the "AND" expressions for each value in searchString.
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            findMatches(searchString: searchString)
        }


        // Match up the fields of the Product object.
        let finalCompoundPredicate =
            NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)


        let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }


        // Apply the filtered results to the search results table.
        if let resultsController = searchController.searchResultsController as? ResultsTableController {
            resultsController.filteredProducts = filteredResults
            resultsController.tableView.reloadData()


            resultsController.resultsLabel.text = resultsController.filteredProducts.isEmpty ?
                NSLocalizedString("NoItemsFoundTitle", comment: "") :
                String(format: NSLocalizedString("Items found: %ld", comment: ""),
                       resultsController.filteredProducts.count)
        }
    }
 */
