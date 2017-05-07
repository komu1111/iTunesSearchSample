//
//  AppRootViewController.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import UIKit

class AppRootViewController: UIViewController {
    
    var searchArtistViewController: SearchArtistViewController!
    var childVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchArtistViewController = SearchArtistViewController.instantiate()
        self.addChildViewController(searchArtistViewController)
        self.view.addSubview(searchArtistViewController.view)
        searchArtistViewController.didMove(toParentViewController: self)
        childVC = searchArtistViewController
    }
}

