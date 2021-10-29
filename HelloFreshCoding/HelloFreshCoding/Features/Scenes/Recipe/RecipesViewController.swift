//
//  RecipesViewController.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import UIKit

final class RecipesViewController: UITableViewController {
    
    // MARK:- Private Properties
    private let viewModel: RecipeViewModel
    private let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK:- Init
    init?(coder: NSCoder, viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.load(with: self)
    }
    
    private func configureUI() {
        self.title = viewModel.screenTitle
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        tableView.backgroundView = spinner
    }
    
    private func reload() {
        Run.onMainThread {
            self.spinner.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRecipeRowViewModels().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecipeTableViewCell = tableView.dequeue(for: indexPath)
        guard let viewModel = viewModel.getRecipeRowViewModel(at: indexPath.row) else { return cell }
        cell.configure(with: viewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.switchRecipeSelection(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
//MARK: ViewModel Delegates
extension RecipesViewController: BaseViewModelDelegate {
    
    func onViewModelReady(_ viewModel: BaseViewModel) {
        self.reload()
    }
    
    func onViewModelError(_ viewModel: BaseViewModel, error: Error) {
        //handle error
        presentAlert(error.localizedDescription)
    }
    
    func onViewModelNeedsUpdate(_ viewModel: BaseViewModel) {
        //needs to udpate
    }
}

