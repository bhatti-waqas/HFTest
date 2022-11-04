//
//  RecipeNavigatorMock.swift
//  HelloFreshCodingTests
//
//  Created by Waqas Naseem on 10/31/21.
//

@testable import HelloFreshCoding

final class RecipeNavigatorMock: RecipeNavigator {
    private(set) var showRecipeDidCall = false
    
    func showRecipeDetail() {
        showRecipeDidCall = true
    }
}
