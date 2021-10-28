//
//  RecipeUseCase.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

protocol RecipeUseCase {
    typealias Completion = (Result<[Recipe], Error>) -> Void
    
    /// it will fetch Recipes.
    /// - Parameter completion: block triggered when fetching is completed.
    func fetchRecipes(then completion: @escaping Completion)
}
