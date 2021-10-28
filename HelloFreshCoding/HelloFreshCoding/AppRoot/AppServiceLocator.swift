//
//  AppServiceLocator.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation
import UIKit

let ServiceLocator = AppServiceLocator.shared

///`AppServiceLocator` is responsible to create/manage all dependencies of the application.
final class AppServiceLocator {
    // MARK:- Class Property
    static let shared = AppServiceLocator()
    
    //MARK:- private Property
    private let recipeUseCase: RecipeUseCase
    
    // MARK:- Init
    private init(){
        //Register dependencies
        let networkService: NetworkServiceProtocol = NetworkService()
        recipeUseCase = NetworkRecipeUseCase(networkService: networkService)
    }
    
    func recipeViewControllersFactory() -> RecipeViewControllersFactory {
        return RecipeViewControllersFactory(recipeUseCase: recipeUseCase)
    }
}
