//
//  RecipeRowViewModel.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

enum SelectionState {
    case selected
    case unselected
}

final class RecipeRowViewModel {
    let id: String
    let name: String
    let headline: String
    let image: String
    let preparationMinutes: Int
    var selectionState: SelectionState
    
    init(id: String, name: String, headline: String, image: String, preparationMinutes: Int, selectionState: SelectionState = .unselected) {
        self.id = id
        self.name = name
        self.headline = headline
        self.image = image
        self.preparationMinutes = preparationMinutes
        self.selectionState = selectionState
    }
}
