//
//  RecipeRowViewModel.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

enum SelecttionState {
    case selected
    case unselected
}

class RecipeRowViewModel {
    let id: String
    let name: String
    let headline: String
    let image: String
    let preparationMinutes: Int
    var selctionState: SelecttionState
    
    init(id: String, name: String, headline: String, image: String, preparationMinutes: Int, selctionState: SelecttionState = .unselected) {
        self.id = id
        self.name = name
        self.headline = headline
        self.image = image
        self.preparationMinutes = preparationMinutes
        self.selctionState = selctionState
    }
}
