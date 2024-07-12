    //
//  RecipeRouter.swift
//  yape-challenge
//
//  Created by devsodep on 23/04/2023.
//

import Foundation
import UIKit
import CoreLocation

class RecipeRouter: PresenterToRouterProtocol {

    var navigationController: UINavigationController?
    static var mainstoryboard: UIStoryboard { UIStoryboard(name: "Main", bundle: .main) }

    func createModule(in window: UIWindow) {
        let view = RecipeRouter.mainstoryboard
            .instantiateViewController(
                withIdentifier: "RecipeViewController"
            ) as! RecipeViewController
        
        let presenter: ViewToPresenterProtocol &
        InteractorToPresenterProtocol = RecipePresenter()
        let interactor: PresenterToInteractorProtocol = RecipeInteractor()

        view.presenter = presenter
        presenter.view = view
        presenter.router = self
        presenter.interactor = interactor
        interactor.presenter = presenter

        navigationController = UINavigationController(rootViewController: view)
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
    }

    func pushToDetailScreen(_ data: RecipeModel) {
        guard let navigationController else { return }
        RecipeDetailRouter()
            .present(navigationController: navigationController,
                     modelSelected: data)
    }
}
