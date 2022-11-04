//
//  AppCoordinator.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import UIKit

/// `AppCoordinator` is responsible to manage transition at windows level.
final class AppCoordinator: BaseCoordinator<AppNavigationController> {
    
    // MARK:- Private Properties
    private let window: UIWindow
    
    // MARK:- Init
    init(window: UIWindow) {
        self.window = window
        super.init(rootViewController: .init())
    }
    
    // MARK:- Public Methods
    override func start() {
        let coordinator = RecipeCoordinator(rootViewController: rootViewController)
        startChild(coordinator)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
