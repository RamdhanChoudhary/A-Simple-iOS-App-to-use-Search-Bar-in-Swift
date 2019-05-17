//
//  ViewController.swift
//  Simple SearchBar
//
//  Created by RAMDHAN CHOUDHARY on 17/05/19.
//  Copyright © 2019 RDC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    let dataArray = ["Mumbai","New Delhi","Jaipur","Bangalore","Pune", "Rishikesh","Chandigarh","Ahemdabad","Udaipur","Amritsar","Darjeeling", "Kolkata"]
    var filteredDataArray = [String]()
    var resultSearchController = UISearchController()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearchControllerAndReloadTableView()
    }
    
    func setupSearchControllerAndReloadTableView()
    {
        resultSearchController = ({
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.sizeToFit()
            
            tableView.tableHeaderView = searchController.searchBar
            
            return searchController
        })()
        
        // Reload the table
        tableView.reloadData()
    }
    
    //MARK:TableView DataSource, Delegate methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return filteredDataArray.count
        } else {
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if (resultSearchController.isActive){
            cell.textLabel?.text = filteredDataArray[indexPath.row]
            return cell
        }
        else {
            cell.textLabel?.text = dataArray[indexPath.row]
            return cell
        }
    }

    //MARK: Search Bar Delegate method
    func updateSearchResults(for searchController: UISearchController) {
        filteredDataArray.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (dataArray as NSArray).filtered(using: searchPredicate)
        filteredDataArray = array as! [String]
        self.tableView.reloadData()
    }
}

