//
//  RecipeModel.swift
//  yape-challenge
//
//  Created by devsodep on 23/04/2023.
//

import Foundation
import CoreLocation
import Kingfisher
import UIKit

struct RecipeListModel: Codable {
    let recipes: [RecipeModel]
}

struct RecipeModel: Codable {
    let extendedIngredients: [Ingredients]
    let title: String
    let image: String
    let summary: String
    let origin: Coordinate
}

struct Coordinate: Codable {
    let lat: Double
    let long: Double

    func locationCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.lat,
                                      longitude: self.long)
    }
}

struct Ingredients: Codable {
    let id: Int
    let aisle: String
    let image: String
    let consistency: String
    let name: String
    let nameClean: String
    let original: String
    let originalName: String
    let amount: Double
    let unit: String
    let measures: Measure
}

struct Measure: Codable {
    let us: MeasureAmount
    let metric: MeasureAmount
}

struct MeasureAmount: Codable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}
