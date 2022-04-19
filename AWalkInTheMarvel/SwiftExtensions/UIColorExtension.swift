//
//  UIColorExtension.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 19/4/22.
//

import UIKit

extension UIColor {
     convenience init(r: CGFloat,g:CGFloat,b:CGFloat,a:CGFloat = 1) {
         self.init(
             red: r / 255.0,
             green: g / 255.0,
             blue: b / 255.0,
             alpha: a
         )
     }
 }
