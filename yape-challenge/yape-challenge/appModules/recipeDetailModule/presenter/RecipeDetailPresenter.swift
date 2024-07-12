//
//  RecipeDetailPresenter.swift
//  yape-challenge
//
//  Created by devsodep on 25/04/2023.
//

import Foundation
import UIKit
import CoreLocation

class RecipeDetailPresenter: RecipeDetailViewToPresenterProtocol {

    weak var view: RecipeDetailPresenterToViewProtocol?
    var router: RecipeDetailPresenterToRouterProtocol?
    var modelSelected: RecipeModel? {
        didSet {
            location = CLLocationCoordinate2D(
                latitude: modelSelected?.origin.lat ?? 0,
                longitude: modelSelected?.origin.long ?? 0)
        }
    }
    var location: CLLocationCoordinate2D?
    
    func showRecipeOriginController() {
        guard let modelSelected, let location else { return }
        router?.pushToMapScreen(data: modelSelected,
                                location: location)
    }

}
