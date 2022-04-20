//
//  UIViewExtension.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 20/4/22.
//

import UIKit

extension UIView {
    var myparentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
