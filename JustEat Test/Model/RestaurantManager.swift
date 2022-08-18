//
//  NetworkManager.swift
//  JustEat Test
//
//  Created by Jack Winterschladen on 17/08/2022.
//

import Foundation

protocol RestaurantManagerDelegate {
    var restaurants: [Restaurant]? { get set }
    func setRestaurants(_ restaurants: [Restaurant])
}

struct RestaurantManager {
    
    let searchURL = "https://uk.api.just-eat.io/restaurants/bypostcode/"
    var delegate: RestaurantManagerDelegate?
    
    func fetchData(postcode: String) {
        if let url = URL(string: searchURL + postcode) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    return
                }
                if let safeData = data {
                    if let restaurants = self.parseJSON(safeData) {
                        delegate?.setRestaurants(restaurants)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ restaurantData: Data) -> [Restaurant]? {
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(RestaurantData.self, from: restaurantData)
            let restaurants = decodedData.Restaurants
            return restaurants
        } catch {
            
            print(error)
            return nil
        }
    }
}
