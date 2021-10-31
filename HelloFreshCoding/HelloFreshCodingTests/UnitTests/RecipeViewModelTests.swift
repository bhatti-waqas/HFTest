//
//  RecipeViewModelTests.swift
//  HelloFreshCodingTests
//
//  Created by Waqas Naseem on 10/31/21.
//
import XCTest
@testable import HelloFreshCoding

final class RecipeViewModelTests: XCTestCase {
    private let navigator = RecipeNavigatorMock()
    private var isReadyStatetriggered: Bool = false
    private var isErrorStatetriggered: Bool = false
    private let errorStateExpectation = XCTestExpectation(description: "Should have error Sate")
    private let readyStateExpectation = XCTestExpectation(description: "Should have ready Sate")
    
    func test_when_fetchingFailed_shouldHaveError() {
        //1. given
        let useCase =  RecipeUseCaesMock()
        let viewModel = RecipeViewModel(with: useCase, navigator: navigator)
        viewModel.delegate = self
        
        //2. when
        viewModel.load()
        
        //waitForExpectations(timeout: 1.0, handler: nil)
        wait(for: [errorStateExpectation], timeout: 1.0)
        //3. then
        XCTAssertTrue(isErrorStatetriggered, "Should trigger error state")
    }
    
    func test_when_fetchingSuccessful_shouldHaveReadyState() {
        //1. given
        let useCase =  RecipeUseCaesMock()
        let recipeies = getMockRecipeResponse()
        useCase.fetchRecipesResult = .success(recipeies)
        let viewModel = RecipeViewModel(with: useCase, navigator: navigator)
        viewModel.delegate = self
        
        //2. when
        viewModel.load()
        
        //waitForExpectations(timeout: 1.0, handler: nil)
        wait(for: [readyStateExpectation], timeout: 1.0)
        //3. then
        XCTAssertTrue(isReadyStatetriggered, "Should trigger ready state")
    }
    
    func test_selection_recipe() {
        //1. given
        let useCase =  RecipeUseCaesMock()
        let recipeies = getMockRecipeResponse()
        useCase.fetchRecipesResult = .success(recipeies)
        let viewModel = RecipeViewModel(with: useCase, navigator: navigator)
        viewModel.delegate = self
        
        //2. when
        viewModel.load()
        viewModel.switchRecipeSelection(at: 0)
        
        //then
        XCTAssertEqual(viewModel.row(at: 0).selectionState, .selected)
    }
    
    func test_deSelection_recipe() {
        //1. given
        let useCase =  RecipeUseCaesMock()
        let recipeies = getMockRecipeResponse()
        useCase.fetchRecipesResult = .success(recipeies)
        let viewModel = RecipeViewModel(with: useCase, navigator: navigator)
        viewModel.delegate = self
        
        //2. when
        viewModel.load()
        viewModel.switchRecipeSelection(at: 0)
        //switch again
        viewModel.switchRecipeSelection(at: 0)
        
        //then
        XCTAssertEqual(viewModel.row(at: 0).selectionState, .unselected)
    }
    
    //test selection shouldn't exceeed 5
    func test_selection_recipe_limit() {
        
        //1. given
        let useCase =  RecipeUseCaesMock()
        let recipeies = getMockRecipeResponse()
        useCase.fetchRecipesResult = .success(recipeies)
        let viewModel = RecipeViewModel(with: useCase, navigator: navigator)
        viewModel.delegate = self
        
        //2. when
        viewModel.load()
        viewModel.switchRecipeSelection(at: 0)
        
        //then
        let numberofSelections = viewModel.numberOfSelections()
        XCTAssertLessThanOrEqual(numberofSelections, 5)
    }
    
    override func tearDown() {
        isReadyStatetriggered = false
        isErrorStatetriggered = false
        super.tearDown()
    }
}
//MARK: ViewModel Delegates
extension RecipeViewModelTests: RecipeViewModelDelegate {
    func onViewModelReady() {
        isReadyStatetriggered = true
        readyStateExpectation.fulfill()
    }
    
    func onViewModelError(with error: Error) {
        isErrorStatetriggered = true
        errorStateExpectation.fulfill()
    }
    
    func onViewModelNeedsUpdate(at index: Int) {
        //
    }
}

//MARK: MockResponseBuilder
extension RecipeViewModelTests {
    private func getMockRecipeResponse() -> [Recipe] {
        do {
            let path = Bundle(for: RecipeViewModelTests.self).path(forResource: "Recipes", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try JSONDecoder().decode([Recipe].self, from: data)
        } catch {
            fatalError("Error: \(error)")
        }
    }
}
