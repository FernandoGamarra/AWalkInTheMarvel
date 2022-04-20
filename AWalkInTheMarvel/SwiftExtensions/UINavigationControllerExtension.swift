//
//  UINavigationControllerExtension.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 20/4/22.
//

import UIKit

extension UINavigationController {
    var previousViewController: UIViewController? {
       viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }
}
