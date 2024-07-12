//
//  API.swift
//  yape-challengeTests
//
//  Created by devsodep on 27/04/2023.
//

import XCTest

final class API: XCTestCase {
    var sut: URLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }

    func testRandomApiCallCompletes() throws {
        // given
        let urlString = "https://demo1409640.mockable.io/recipes"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

        // when
        let dataTask = sut.dataTask(with: url) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 50)

        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }


    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }   

}
