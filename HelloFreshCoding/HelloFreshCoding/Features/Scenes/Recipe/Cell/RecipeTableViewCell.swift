//
//  RecipeTableViewCell.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
    //MARK:- private properties
    @IBOutlet weak var containerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var headlineLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var recipeImageview: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        containerView.layer.borderColor = UIColor.green.cgColor
    }
    
    //MARK:- public methods
    func configureUnselected() {
        containerView.layer.borderWidth = 0
    }
    
    func configureSelected() {
        containerView.layer.borderWidth = 2
    }
    
    func configure(with viewModel: RecipeRowViewModel) {
        nameLabel.text = viewModel.name
        headlineLabel.text = viewModel.headline
        durationLabel.text = viewModel.preparationMinutes.toString()
        recipeImageview.setImage(with: URL(string: viewModel.image))
        containerView.layer.borderWidth = viewModel.selctionState == .selected ? 2 : 0
    }
}
