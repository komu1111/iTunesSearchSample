//
//  iTuensSearchResponse.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import Foundation

struct iTunesSearchResponse<T>: iTuensResponse {
    let value: T
}

