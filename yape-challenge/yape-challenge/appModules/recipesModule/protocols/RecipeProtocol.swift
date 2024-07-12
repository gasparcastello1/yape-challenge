//
//  RecipeProtocol.swift
//  yape-challenge
//
//  Created by devsodep on 23/04/2023.
//

import Foundation
import UIKit
import CoreLocation

protocol ViewToPresenterProtocol: AnyObject {
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }

    var recipesCount: Int { get }
    var viewModel: RecipeListModel? { get }

    func prefetchTableImages(indexPaths: [IndexPath])
    func startFetchingRecipes()
    func showRecipeDetailController(data: RecipeModel)
    func getRecipe(at index: Int) -> RecipeModel?
    func textdidChanged(searchText: String)
}

protocol PresenterToViewProtocol: AnyObject {
    func updateUI()
    func showError(error: Error)
}

protocol PresenterToRouterProtocol: AnyObject {
    func createModule(in window: UIWindow) 
    func pushToDetailScreen(_ data: RecipeModel)
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter: InteractorToPresenterProtocol? { get set }
    func fetchRecipe()
}

protocol InteractorToPresenterProtocol: AnyObject {
    func recipeFetchedSuccess(modelSelected: RecipeListModel)
    func recipeFetchFailed(error: Error)
}

