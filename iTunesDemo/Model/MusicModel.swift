//
//  MusicModel.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/4.
//

import Foundation

struct MusicModel: Codable {
    
    let wrapperType:String
    
    let kind:String?
    
    let artistId: Int
    let artistName, artistViewUrl: String?
    let artistLinkUrl,artworkUrl100, artworkUrl30,artworkUrl60: String?
    
    let collectionId: Int?
    let collectionName: String?
    let collectionViewUrl: String?
    
    
    let trackId: Int?
    let trackName: String?
    let trackCensoredName: String?
    let trackViewUrl: String?
    
    let country:String?
    
    enum MediaType {
        case artist
        case song
        case album
        case unowned
        static let all:[Self] = [.artist,.song,.album]
        init(_ str:String){
            switch str {
            case "artist":
                self = .artist
            case "collection":
                self = .album
            case "track":
                self = .song
            default:
                self = .unowned
            }
        }
    }
    var mediaType:MediaType{
        MediaType(wrapperType)
    }
}
