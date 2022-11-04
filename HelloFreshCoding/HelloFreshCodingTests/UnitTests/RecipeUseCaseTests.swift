//
//  RecipeUseCaseTests.swift
//  HelloFreshCodingTests
//
//  Created by Waqas Naseem on 10/29/21.
//

import XCTest
@testable import HelloFreshCoding

final class RecipeUseCaseTests: XCTestCase {
    private let networkService = NetworkServiceMock()
    private var useCase: RecipeUseCase!
    
    override func setUp() {
        useCase = NetworkRecipeUseCase(networkService: networkService)
    }
    
    func test_fetchRecipesSucceeds() {
        // Given
        var result: Result<[Recipe], Error>!
        let expectation = self.expectation(description: "Recipes")
        let recipes = getMockRecipeResponse()
        networkService.responses[APIURLs.recipesUrl] = recipes
        //when
        useCase.fetchRecipes(then: { value in
            result = value
            expectation.fulfill()
        })
        
        // Then
        self.waitForExpectations(timeout: 2.0, handler: nil)
        guard case .success = result else {
            XCTFail()
            return
        }
    }
    
    func test_fetchRecipesFails_onNetworkError() {
        // Given
        var result: Result<[Recipe], Error>!
        let expectation = self.expectation(description: "Recipes")
        networkService.responses[APIURLs.recipesUrl] = NetworkError.notFound

        //when
        useCase.fetchRecipes(then: { value in
            result = value
            expectation.fulfill()
        })
        // Then
        self.waitForExpectations(timeout: 2.0, handler: nil)
        guard case .failure = result! else {
            XCTFail()
            return
        }
    }
    
    override func tearDown() {
        useCase = nil
        super.tearDown()
    }
}
//MARK: MockResponseBuilder
extension RecipeUseCaseTests {
    private func getMockRecipeResponse() -> [Recipe] {
        do {
            let path = Bundle(for: RecipeUseCaseTests.self).path(forResource: "Recipes", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try JSONDecoder().decode([Recipe].self, from: data)
        } catch {
            fatalError("Error: \(error)")
        }
    }
}
