//
//  RecipeViewControllerTests.swift
//  HelloFreshCodingTests
//
//  Created by Waqas Naseem on 10/29/21.
//

import XCTest
import UIKit
@testable import HelloFreshCoding

class RecipeViewControllerTests: XCTestCase {

    private var viewModel: RecipeViewModel!
    fileprivate var useCase: RecipeUseCase!
    fileprivate var recipeViewController: RecipesViewController!
    
    override func setUp() {
        let mockService = NetworkServiceMock()
        useCase = NetworkRecipeUseCase(networkService: mockService)
        viewModel = RecipeViewModel(with: useCase)
        
    }
    
    func test_selection_recipe() {
        //given
        let recipeViewModels = getMockRecipeResponse().map(makeRecipeRowViewModel(with:))
        viewModel.setRecipeViewModels(viewModels: recipeViewModels)
        let storyboard = UIStoryboard(name: .recipe)
        let viewController = storyboard.instantiateInitialViewController {
            RecipesViewController(coder: $0, viewModel: self.viewModel)
        }
        guard let recipeViewController = viewController else {
            XCTFail()
            return
        }
        let tableView = UITableView()
        //when
        recipeViewController.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        //then
        XCTAssertEqual(viewModel.getRecipeRowViewModel(at: 0)?.selctionState, .selected)
    }
    
    func test_deSelection_recipe() {
        //given
        let recipeViewModels = getMockRecipeResponse().map(makeRecipeRowViewModel(with:))
        viewModel.setRecipeViewModels(viewModels: recipeViewModels)
        let recipeRowViewModel = viewModel.getRecipeRowViewModel(at: 0)
        recipeRowViewModel?.selctionState = .selected
        let storyboard = UIStoryboard(name: .recipe)
        let viewController = storyboard.instantiateInitialViewController {
            RecipesViewController(coder: $0, viewModel: self.viewModel)
        }
        guard let recipeViewController = viewController else {
            XCTFail()
            return
        }
        let tableView = UITableView()
        //when
        recipeViewController.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        //then
        XCTAssertEqual(viewModel.getRecipeRowViewModel(at: 0)?.selctionState, .unselected)
    }
    
    //test selection shouldn't exceeed 5
    func test_selection_recipe_limit() {
        //given
        let recipeViewModels = getMockRecipeResponse().map(makeRecipeRowViewModel(with:))
        viewModel.setRecipeViewModels(viewModels: recipeViewModels)
        
        let storyboard = UIStoryboard(name: .recipe)
        let viewController = storyboard.instantiateInitialViewController {
            RecipesViewController(coder: $0, viewModel: self.viewModel)
        }
        guard let recipeViewController = viewController else {
            XCTFail()
            return
        }
        let tableView = UITableView()
        //when
        recipeViewController.tableView(tableView, didSelectRowAt: IndexPath(row: 1, section: 0))

        //then
        let numberofSelected = viewModel.getRecipeRowViewModels().filter{$0.selctionState == .selected}.count
        XCTAssertLessThanOrEqual(numberofSelected, 5)
    }
    
    override func tearDown() {
        viewModel = nil
        useCase = nil
        super.tearDown()
    }
}

//MARK: MockResponseBuilder
extension RecipeViewControllerTests {
    private func getMockRecipeResponse() -> [Recipe] {
        do {
            let path = Bundle(for: RecipeViewControllerTests.self).path(forResource: "Recipes", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try JSONDecoder().decode([Recipe].self, from: data)
        } catch {
            fatalError("Error: \(error)")
        }
    }
    
    private func makeRecipeRowViewModel(with recipe: Recipe) -> RecipeRowViewModel {
        .init(id: recipe.id, name: recipe.name, headline: recipe.headline, image: recipe.image, preparationMinutes: recipe.preparationMinutes)
    }
}
