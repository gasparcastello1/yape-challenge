//
//  yapeInteractorTest.swift
//  yape-challengeTests
//
//  Created by devsodep on 27/04/2023.
//

import XCTest
@testable import yape_challenge

final class yapeInteractorTest: XCTestCase {

    var sut: RecipeInteractor?
    var mockPresenter: MockRecipePresenter?
    let mockData =  RecipeListModel(
        recipes: [
            RecipeModel(
                extendedIngredients:
                    [Ingredients](),
                title: "",
                image: "",
                summary: "",
                origin: Coordinate(
                    lat: 0,
                    long: 0)
            )
        ]
    )

    override func setUp() {
        sut = RecipeInteractor()
        mockPresenter = MockRecipePresenter()
        sut?.presenter = mockPresenter
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        mockPresenter = nil
        super.tearDown()
    }

    func testFetchingSuccess() {
        sut?.fetchRecipe()
        sut?.presenter?.recipeFetchedSuccess(
            modelSelected: mockData
        )
        XCTAssertTrue(mockPresenter!.isSuccess)
        XCTAssertNil(mockPresenter?.error)
    }

}

class MockRecipePresenter: InteractorToPresenterProtocol {

    var isSuccess: Bool
    var error: Error?

    init() {
        isSuccess = false // set default value here
    }
    func recipeFetchedSuccess(modelSelected: RecipeListModel) {
        self.isSuccess = true
    }

    func recipeFetchFailed(error: Error) {
        self.error = error
    }
}
