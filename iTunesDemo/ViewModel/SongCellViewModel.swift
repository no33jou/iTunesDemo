//
//  Song.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Foundation
import UIKit

struct SongCellViewModel: MusicCellViewModel{
    
    
    let data:MusicModel
    var imageShape: ShapeType
    
    var imageUrl: URL?
    
    var title: String?
    
    var detail: String?

    var actionItem: ActionItem?
    
    var viewURL: URL?
    /// 是否被收藏
    var isBookmark = false{
        didSet{
            actionItem = .button(UIImage(systemName: isBookmark ? "star.fill" : "star")!)
        }
    }
    
    init(_ data:MusicModel){
        self.data = data
        
        if let url = data.artworkUrl100 {
            imageUrl = URL(string: url)
        }
        self.imageShape = .round(8)
        self.title = data.trackName
        
        if let name = data.artistName {
            self.detail = "\(Localiz.Search.song.str) · \(name)"
        }
        
        if let url = data.trackViewUrl{
            self.viewURL = URL(string: url)
        }

    }
}
