//
//  NetworkRecipeUseCase.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

final class NetworkRecipeUseCase {
    // MARK:- Private Properties
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
//MARK:- RecipeUse case implementation
extension NetworkRecipeUseCase: RecipeUseCase {
    
    func fetchRecipes(then completion: @escaping Completion) {
        
        networkService.fetch(APIURLs.recipesUrl) { (response:Result<[Recipe],Error>) in
            switch response {
            case .success(let recipes):
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
