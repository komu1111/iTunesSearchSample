//
//  Storyboardable.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import UIKit

protocol Storyboardable: NSObjectProtocol {
    static var storyboardName: String { get }
    static func instantiate() -> Self
}

extension Storyboardable where Self: UIViewController {
    static var storyboardName: String {
        return className
    }
    
    static func instantiate() -> Self {
        return UIStoryboard(name: storyboardName, bundle: .main).instantiateInitialViewController() as! Self
    }
}

