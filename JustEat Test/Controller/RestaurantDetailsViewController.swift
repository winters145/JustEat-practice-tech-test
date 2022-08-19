//
//  RestaurantDetailsViewController.swift
//  JustEat Test
//
//  Created by Jack Winterschladen on 17/08/2022.
//

import UIKit

class RestaurantDetailsViewController: UITableViewController {

    var currentRestaurant: Restaurant?
    var cuisines: [String] = []
    var cuisineString = ""
    var logo: UIImage?
    
    @IBOutlet weak var restaurantLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let restaurant = currentRestaurant?.CuisineTypes {
            for cuisine in restaurant {
                cuisines.append(cuisine.Name)
            }
        }
        cuisineString = cuisines.joined(separator: ", ")
        
        title = currentRestaurant?.Name
        restaurantLogo.image = logo
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath)
        
        var cellContent = cell.defaultContentConfiguration()
        if indexPath.section == 0 {
            cellContent.text = "\(currentRestaurant?.RatingAverage ?? 0)"
        } else {
            cellContent.text = cuisineString
        }
        
        cell.contentConfiguration = cellContent
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Average Rating"
        } else {
            return "Cusines"
        }
    }
}
