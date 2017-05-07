//
//  UIView+Extension.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/07.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

