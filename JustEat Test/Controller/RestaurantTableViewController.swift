//
//  ViewController.swift
//  JustEat Test
//
//  Created by Jack Winterschladen on 17/08/2022.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var restaurants: [Restaurant]?
    var networkManager = RestaurantManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        searchBar.delegate = self
    }

    //MARK: - Table View data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath)
        var cellContent = cell.defaultContentConfiguration()
        
        if let restaurant = restaurants?[indexPath.row] {
            cellContent = setContent(for: cell, from: restaurant)
        }
        
        cell.contentConfiguration = cellContent
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    //MARK: - SetContent for cell method
    
    func setContent(for cell: UITableViewCell, from restaurant: Restaurant) -> UIListContentConfiguration {
        var content = cell.defaultContentConfiguration()
        
        content.text = restaurant.Name
        content.textProperties.color = UIColor(named: "JustEatOrange")!
        content.textProperties.font = .systemFont(ofSize: 35)
        content.image = setImage(for: restaurant)
        content.secondaryText = restaurant.IsOpenNow ? "Open" : "Closed"
        content.secondaryTextProperties.font = .systemFont(ofSize: 20)
        return content
    }
    
    //MARK: - Prepare for segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RestaurantDetailsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.currentRestaurant = restaurants?[indexPath.row]
            destinationVC.logo = setImage(for: restaurants?[indexPath.row])
        }
    }
}


//MARK: - SearchBar methods

extension RestaurantTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let postcode = searchBar.text {
            networkManager.fetchData(postcode: postcode)
        }
        self.searchBar.text = ""
    }
}

//MARK: - Restaurant Manager Delegate methods

extension RestaurantTableViewController: RestaurantManagerDelegate {
    
    func setRestaurants(_ restaurants: [Restaurant]) {
        DispatchQueue.main.async {
            self.restaurants = restaurants
            self.tableView.reloadData()
        }
    }
    
    func setImage(for restaurant: Restaurant?) -> UIImage? {
        guard restaurant != nil else { return nil }
        var logoURLString = restaurant!.LogoUrl.absoluteString
        logoURLString.insert("s", at: logoURLString.index(logoURLString.startIndex, offsetBy: 4))
        let logoURL = URL(string: logoURLString)
        if let data = try? Data(contentsOf: logoURL!) {
            if let logo = UIImage(data: data) {
                return logo
            }
        }
        return nil
    }
}
