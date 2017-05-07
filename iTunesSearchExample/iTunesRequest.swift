//
//  iTunesRequest.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import Foundation
import APIKit

protocol iTunesRequest: Request {
    associatedtype Response: iTuensResponse
}

extension iTunesRequest {
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
}

