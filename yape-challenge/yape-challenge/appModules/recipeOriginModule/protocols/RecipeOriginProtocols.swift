//
//  RecipeOriginProtocols.swift
//  yape-challenge
//
//  Created by devsodep on 26/04/2023.
//

import Foundation
import UIKit
import CoreLocation

protocol RecipeOriginViewToPresenterProtocol: AnyObject {
    var view: RecipeOriginPresenterToViewProtocol? { get set }
    var router: RecipeOriginPresenterToRouterProtocol? { get set }
    var modelSelected: RecipeModel? { get set }
    var location: CLLocationCoordinate2D? { get set }

    func launchInMapApp()
}

protocol RecipeOriginPresenterToViewProtocol: AnyObject {
    func updateUI()
    func showError(error: Error)
}

protocol RecipeOriginPresenterToRouterProtocol: AnyObject {
    func present(navigationController: UINavigationController,
                 location: CLLocationCoordinate2D,
                 modelSelected: RecipeModel)
    func launchInMapApp(data: RecipeModel,
                        location: CLLocationCoordinate2D)
}
