//
//  RecipeUseCaseMock.swift
//  HelloFreshCodingTests
//
//  Created by Waqas Naseem on 10/31/21.
//

@testable import HelloFreshCoding

final class RecipeUseCaesMock: RecipeUseCase {
    var fetchRecipesResult: Result<[Recipe], Error> = .failure(NetworkError.notFound)
    
    func fetchRecipes(then completion: @escaping Completion) {
        completion(fetchRecipesResult)
    }
}
