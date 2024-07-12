//
//  RecipeDetailProtocols.swift
//  yape-challenge
//
//  Created by devsodep on 25/04/2023.
//

import Foundation
import UIKit
import CoreLocation

protocol RecipeDetailViewToPresenterProtocol: AnyObject {
    var view: RecipeDetailPresenterToViewProtocol? { get set }
    var router: RecipeDetailPresenterToRouterProtocol? { get set }
    var modelSelected: RecipeModel? { get set }
    var location: CLLocationCoordinate2D? { get set }

    func showRecipeOriginController()
}

protocol RecipeDetailPresenterToViewProtocol: AnyObject {
    func updateUI()
    func showError(error: Error)
}

protocol RecipeDetailPresenterToRouterProtocol: AnyObject {
    func present(navigationController: UINavigationController,
                 modelSelected: RecipeModel)
    func pushToMapScreen(data: RecipeModel,
                         location: CLLocationCoordinate2D)
}

