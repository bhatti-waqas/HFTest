//
//  AppNavigationController.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//


import UIKit

final class AppNavigationController: UINavigationController {
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
            
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(.avenirDemiBold, size: .standard(.h3))]
    }
}
