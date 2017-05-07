//
//  iTunesResponse.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import Foundation

protocol iTuensResponse {
    associatedtype ValueType
    var value: ValueType { get }
    
}

