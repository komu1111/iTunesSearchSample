//
//  SearchArtistViewCell.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import UIKit
import Kingfisher

class SearchArtistViewCell: UITableViewCell, Nibable {
    
    static let defaultHeight: CGFloat = 80
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with song: iTunesSong) {
        coverImageView.kf.cancelDownloadTask()
        songName.text = song.songName
        artistName.text = song.artistName
        coverImageView.kf.setImage(with: song.imageUrl, options: [.transition(.fade(0.3))])
    }
}

