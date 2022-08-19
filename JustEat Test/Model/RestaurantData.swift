//
//  RestaurantData.swift
//  JustEat Test
//
//  Created by Jack Winterschladen on 17/08/2022.
//

import Foundation

protocol RestaurantProtocol {
    var Name: String { get }
    var RatingAverage: Double { get }
    var CuisineTypes: [Cuisine] { get }
    var LogoUrl: URL { get }
    var IsOpenNow: Bool { get }
}

struct RestaurantData: Codable {
    let Restaurants: [Restaurant]
}

struct Restaurant: Codable, RestaurantProtocol {
    let Name: String
    let RatingAverage: Double
    let CuisineTypes: [Cuisine]
    let LogoUrl: URL
    let IsOpenNow: Bool
}

struct Cuisine: Codable {
    let Name: String
}
