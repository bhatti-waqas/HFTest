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
        viewModel.delegate = self
        viewModel.load()
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
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecipeTableViewCell = tableView.dequeue(for: indexPath)
        let viewModel = viewModel.row(at: indexPath.row)
        cell.configure(with: viewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.switchRecipeSelection(at: indexPath.row)
    }
    
}
//MARK: ViewModel Delegates
extension RecipesViewController: RecipeViewModelDelegate {
    
    func onViewModelReady() {
        self.reload()
    }
    
    func onViewModelError(with error: Error) {
        presentAlert(error.localizedDescription)
    }
    
    func onViewModelNeedsUpdate(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
}

