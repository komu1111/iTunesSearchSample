//
//  UITableView+Extension.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type) where T: Nibable {
        return register(T.nib, forCellReuseIdentifier: T.className)
    }
    
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        return register(T.self, forCellReuseIdentifier: T.className)
    }
    
    func dequeueReuseableCell<T: UITableViewCell>(with cellType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
}

