//
//  RecipeCoordinator.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import UIKit

final class RecipeCoordinator: BaseCoordinator<AppNavigationController> {
    
    override func start() {
        let factory = ServiceLocator.recipeViewControllersFactory()
        let recipeViewController = factory.makeRecipeViewController()
        recipeViewController.title = "Recipes"
        rootViewController.pushViewController(recipeViewController, animated: true)
    }
}
