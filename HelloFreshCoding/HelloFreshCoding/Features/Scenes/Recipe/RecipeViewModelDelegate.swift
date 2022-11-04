//
//  RecipeViewModel.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

public protocol RecipeViewModelDelegate : AnyObject {
    func onViewModelReady()
    func onViewModelError(with error: Error)
    func onViewModelNeedsUpdate(at index: IndexPath)
}

public enum SelectionError: LocalizedError {
    // Error cases
    case maxLimitReached
    
    public var errorDescription: String? {
        switch self {
        case .maxLimitReached:
            return "You can select only up-to 5 recipes."
        }
    }
}

protocol RecipeNavigator: AnyObject {
    func showRecipeDetail()
}
