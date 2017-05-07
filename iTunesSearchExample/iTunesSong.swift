//
//  iTunesSong.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import Foundation
import Himotoki

struct iTunesSong: Decodable {
    
    let artistName: String
    let songName: String
    let imageUrl: URL
    
    init(artistName: String, songName: String, imageUrl: String) throws {
        guard let _imageUrl = URL(string: imageUrl) else {
            throw DecodeError.custom("Cannot generate url with \(imageUrl)")
        }
        self.artistName = artistName
        self.songName = songName
        self.imageUrl = _imageUrl
    }
    
    static func decode(_ e: Extractor) throws -> iTunesSong {
        return try iTunesSong(
            artistName: e <| "artistName",
            songName: e <| "trackName",
            imageUrl: e <| "artworkUrl100"
        )
    }
}

