//
//  AlbumCellViewModel.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/6.
//

import Foundation

struct AlbumCellViewModel: MusicCellViewModel {
    var imageUrl: URL?
    
    var imageShape: ShapeType
    
    var title: String?
    
    var detail: String?
    
    var actionItem: ActionItem?
    
    var viewURL: URL?
    
    let data:MusicModel
    init(_ data:MusicModel){
        self.data = data
        
        self.imageUrl = URL(string: data.artworkUrl100 ?? "")
        self.imageShape = .round(8)
        self.title = data.collectionName
        self.detail = "\(Localiz.Search.album.stringFromLocal()) · \(data.artistName ?? "")"
        if let url = data.collectionViewUrl{
            self.viewURL = URL(string: url)
        }
    }
}
