//
//  RecipeViewModel.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

final class RecipeViewModel {
    private struct Config {
        static let maxSelectionAllowed = 5
    }
    
    public weak var delegate : RecipeViewModelDelegate?
    private var ready:Bool = false
    private var loading:Bool = false
    
    let screenTitle = "Recipes"
    private let recipeUseCase: RecipeUseCase
    private unowned let navigator: RecipeNavigator
    private var recipeRowViewModels: [RecipeRowViewModel] = []
    
    init(with useCase: RecipeUseCase, navigator: RecipeNavigator) {
        self.recipeUseCase = useCase
        self.navigator = navigator
    }
    
    //MARK:- Public methods
    public func load() {
        self.loading = true
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
        
    public func makeReady() {
        self.ready = true
        self.loading = false
        self.delegate?.onViewModelReady()
    }
    
    public func numberOfRows() -> Int {
        recipeRowViewModels.count
    }
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func row(at index: Int) -> RecipeRowViewModel {
        recipeRowViewModels[index]
    }
    
    public func numberOfSelections() -> Int {
        let selectedRecipes = recipeRowViewModels.filter{ $0.selectionState == .selected }
        return selectedRecipes.count
    }
    
    public func switchRecipeSelection(at index: Int) {
        let rowViewModel = recipeRowViewModels[index]
        if rowViewModel.selectionState == .selected {
            rowViewModel.selectionState = .unselected
        } else {
            guard canSelectRecipe() else {
                self.throwError(with: SelectionError.maxLimitReached)
                return
            }
            rowViewModel.selectionState = .selected
        }
        self.delegate?.onViewModelNeedsUpdate(at: index)
    }
    
    public func throwError(with error: Error) {
        //In some cases we are receving errors from background threads.
        //We need to make sure we use main thread since we are going to interact with UI
        Run.onMainThread {
            self.loading = false
            self.delegate?.onViewModelError(with: error)
        }
    }
    
    //MARK:- Private methods
    private func makeRecipeRowViewModel(with recipe: Recipe) -> RecipeRowViewModel {
        .init(id: recipe.id, name: recipe.name, headline: recipe.headline, image: recipe.image, preparationMinutes: recipe.preparationMinutes)
    }
    
    private func canSelectRecipe() -> Bool {
        return numberOfSelections() < Config.maxSelectionAllowed
    }
}
