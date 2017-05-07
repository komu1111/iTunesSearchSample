//
//  iTunesSearchRequest.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import Foundation
import Himotoki
import APIKit

struct iTunesSearchRequest: iTunesRequest {
    typealias Response = iTunesSearchResponse<[iTunesSong]>
    
    //https://itunes.apple.com/search?term=Perfume&country=jp&lang=ja_jp&media=music&entity=song&attribute=artistTerm&limit=20
    let term: String
    let country: String = "jp"
    let lang: String = "ja_jp"
    let media: String = "music"
    let entity: String = "song"
    
    let method: HTTPMethod = .get
    let path: String = "/search"
    
    var queryParameters: [String: Any]? {
        return [
            "term": term,
            "country": country,
            "lang": lang,
            "media": media,
            "entity": entity            
        ]
    }
    
    init(term: String) {
        self.term = term
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        let songs: [iTunesSong] = try decodeArray(object, rootKeyPath: "results")
        return iTunesSearchResponse(value: songs)
    }
}

