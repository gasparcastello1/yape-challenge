//
//  yapePresenterTest.swift
//  yape-challengeTests
//
//  Created by devsodep on 27/04/2023.
//

import XCTest
@testable import yape_challenge

final class yapePresenterTest: XCTestCase {

    var sut: RecipePresenter?
    var mockView: MockRecipeViewController?
    var mockInteractor: MockRecipeInteractor?
    var mockRouter: MockRecipenRouter?

    override func setUp() {
        sut = RecipePresenter()
        mockView = MockRecipeViewController()
        mockInteractor = MockRecipeInteractor()
        mockRouter = MockRecipenRouter()
        mockInteractor?.presenter = sut
        sut?.view = mockView
        sut?.interactor = mockInteractor
        sut?.router = mockRouter
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }


    func testWhenFailureItShowsError() {
        mockInteractor?.failed()
        sut?.startFetchingRecipes()
        XCTAssertTrue(mockView?.showAlert ?? false)
    }

}


class MockRecipeViewController: PresenterToViewProtocol {
    var showAlert: Bool = false

    func updateUI() {

    }
    func showError(error: Error) {
        showAlert = true
    }
}

class MockRecipeInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    var fail = false
    func failed() {
        fail = true
        presenter?.recipeFetchFailed(error: ErrorCode.badRequest)
    }
    func fetchRecipe() {

    }

}

enum ErrorCode: Error {
    case timeOut
    case badRequest
}

class MockRecipenRouter: PresenterToRouterProtocol {
    func createModule(in window: UIWindow) {

    }

    func pushToDetailScreen(_ data: yape_challenge.RecipeModel) {

    }
}
