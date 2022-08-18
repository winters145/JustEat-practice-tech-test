//
//  RestaurantData.swift
//  JustEat Test
//
//  Created by Jack Winterschladen on 17/08/2022.
//

import Foundation

struct RestaurantData: Codable {
    let Restaurants: [Restaurant]
}

struct Restaurant: Codable {
    let Name: String
    let RatingAverage: Double
    let CuisineTypes: [Cuisine]
    let LogoUrl: URL
    let IsOpenNow: Bool
}

struct Cuisine: Codable {
    let Name: String
}
