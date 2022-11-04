//
//  UIImageView.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import UIKit
import SDWebImage

extension UIImageView {
  func setImage(with url: URL?) {
    backgroundColor = .black
    if let imageURL = url {
      sd_setImage(with: imageURL,
                  placeholderImage: UIImage(named: "defaultCarImg"),
                  options: [.scaleDownLargeImages], completed: nil)
    } else {
      image = UIImage(named: "defaultCarImg")
    }
    layer.cornerRadius = 8.0
    layer.masksToBounds = true
  }
}
