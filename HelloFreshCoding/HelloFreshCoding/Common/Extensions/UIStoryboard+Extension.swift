//
//  UIStoryboard+Extension.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import UIKit

extension UIStoryboard {
    enum Name: String {
        case recipe = "Recipe"
    }
    
    convenience init(name: Name, bundle: Bundle? = nil) {
        self.init(name: name.rawValue, bundle: bundle)
    }
    
    func initialViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateInitialViewController() as? T else {
            fatalError("Could not locate view controller in storyboard.")
        }
        
        return viewController
    }
}
