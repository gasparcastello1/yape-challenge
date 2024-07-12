//
//  RecipePresenter.swift
//  yape-challenge
//
//  Created by devsodep on 23/04/2023.
//

import Foundation
import UIKit
import Kingfisher

class RecipePresenter: ViewToPresenterProtocol {
    weak var view: PresenterToViewProtocol?
    var viewModel: RecipeListModel?
    var filteredList: RecipeListModel?
    var recipesCount: Int {
        isFilterOn ?
        filteredList?.recipes.count ?? 0 :
        viewModel?.recipes.count ?? 0
    }
    var isFilterOn = false
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?

    func startFetchingRecipes() {
        interactor?.fetchRecipe()
    }

    func showRecipeDetailController(data: RecipeModel) {
        router?.pushToDetailScreen(data)
    }

    func getRecipe(at index: Int) -> RecipeModel? {
        let recipes = isFilterOn ?
        filteredList?.recipes :
        viewModel?.recipes
        return recipes?[index]
    }

    func textdidChanged(searchText: String) {
        guard let viewModel, let view else { return }
        if searchText.isEmpty {
            filteredList = viewModel
            view.updateUI()
            return
        }
        isFilterOn = true
        let filtered = viewModel.recipes.filter { model in
            model.title.lowercased()
                .contains(searchText.lowercased()) ||
            model.extendedIngredients.first(where: { ingredients in
                ingredients.name.lowercased()
                    .contains(searchText.lowercased()) ||
                ingredients.nameClean.lowercased()
                    .contains(searchText.lowercased()) ||
                ingredients.originalName.lowercased()
                    .contains(searchText.lowercased())
            }) != nil
        }
        filteredList = RecipeListModel(recipes: filtered)
        view.updateUI()
    }

    func prefetchTableImages(indexPaths: [IndexPath]) {
        guard let viewModel else { return }
        let urls = indexPaths
            .compactMap { URL(string: viewModel.recipes[$0.row].image
            )}
        ImagePrefetcher(urls: urls) {
            skipped, failed, completed in
            print(" prefetched: \(completed)")
            print(" skipped: \(skipped)")
            print(" failed: \(failed)")
        }.start()
    }

}

extension RecipePresenter: InteractorToPresenterProtocol {
    func recipeFetchedSuccess(modelSelected: RecipeListModel) {
        viewModel = modelSelected
        view?.updateUI()
    }

    func recipeFetchFailed(error: Error) {
        view?.showError(error: error)
    }

}
