//
//  RecipeDetailRouter.swift
//  yape-challenge
//
//  Created by devsodep on 25/04/2023.
//

import Foundation
import UIKit
import CoreLocation

class RecipeDetailRouter: RecipeDetailPresenterToRouterProtocol {

    var navigationController: UINavigationController?

    func present(navigationController: UINavigationController,
                 modelSelected: RecipeModel) {
        self.navigationController = navigationController

        let view = RecipeRouter.mainstoryboard
            .instantiateViewController(
                withIdentifier: "RecipeDetailViewController"
            ) as! RecipeDetailViewController

        let presenter: RecipeDetailViewToPresenterProtocol =
        RecipeDetailPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = self
        presenter.modelSelected = modelSelected

        navigationController.pushViewController(view, animated: true)
    }

    func pushToMapScreen(data: RecipeModel,
                         location: CLLocationCoordinate2D) {
        guard let navigationController else { return }
        RecipeOriginRouter()
            .present(navigationController: navigationController,
                     location: location,
                     modelSelected: data)
    }
}

