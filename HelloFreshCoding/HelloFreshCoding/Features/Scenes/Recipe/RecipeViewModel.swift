//
//  RecipeViewModel.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

final class RecipeViewModel: BaseViewModel {
    
    private struct Config {
        static let maxSelectionAllowed = 5
    }

    let screenTitle = "Recipes"
    private let recipeUseCase: RecipeUseCase
    private var recipeRowViewModels: [RecipeRowViewModel] = []
    
    //var recipes: [Recipe] = []
    
    init(with useCase: RecipeUseCase) {
        self.recipeUseCase = useCase
    }
    
    override func load(with delegate: BaseViewModelDelegate) {
        super.load(with: delegate)
        recipeUseCase.fetchRecipes(then: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let recipes):
                let recipeRows = recipes.map(self.makeRecipeRowViewModel(with:))
                self.recipeRowViewModels = recipeRows
                self.makeReady()
            case .failure(let error):
                self.throwError(with: error)
            }
        })
    }
    
    //MARK:- Private methods
    private func makeRecipeRowViewModel(with recipe: Recipe) -> RecipeRowViewModel {
        .init(id: recipe.id, name: recipe.name, headline: recipe.headline, image: recipe.image, preparationMinutes: recipe.preparationMinutes)
    }
    
    private func canSelect() -> Bool {
        let selectedRecipes = recipeRowViewModels.filter{ $0.selctionState == .selected }
        return selectedRecipes.count < Config.maxSelectionAllowed
    }
    
    //MARK:- Public methods
    public func getRecipeRowViewModels() -> [RecipeRowViewModel] {
        return recipeRowViewModels
    }
    
    public func getRecipeRowViewModel(at index: Int) -> RecipeRowViewModel? {
        return recipeRowViewModels[safe: index]
    }
    
    public func switchRecipeSelection(at index: Int) {
        guard let rowViewModel = recipeRowViewModels[safe: index] else { return }
        if rowViewModel.selctionState == .selected {
            rowViewModel.selctionState = .unselected
        } else {
            guard canSelect() else { return }
            rowViewModel.selctionState = .selected
        }
        self.delegate?.onViewModelNeedsUpdate(self)
    }
}