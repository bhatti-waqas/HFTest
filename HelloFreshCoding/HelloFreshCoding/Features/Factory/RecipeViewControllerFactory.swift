//
//  RecipeViewControllerFactory.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation
import UIKit

final class RecipeViewControllersFactory {
    // MARK:- Private Properties
    private let recipeUseCase: RecipeUseCase
    
    // MARK:- Init
    init(recipeUseCase: RecipeUseCase) {
        self.recipeUseCase = recipeUseCase
    }
    
    // MARK:- Public Methods
    func makeRecipeViewController() -> RecipesViewController {
        let storyboard = UIStoryboard(name: .recipe)
        let viewModel = RecipeViewModel(with: recipeUseCase)
        let viewController = storyboard.instantiateInitialViewController {
            RecipesViewController(coder: $0, viewModel: viewModel)
        }
        guard let recipeViewController = viewController else {
            fatalError("Failed to load RecipeViewController from storyboard.")
        }
        return recipeViewController
    }
}
