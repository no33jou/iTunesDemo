//
//  iTunesAPIService.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/4.
//

import Foundation

let iTunesHost = "https://itunes.apple.com"

struct iTunesResponseResult<M: Codable>: Codable {
    let resultCount: Int
    let results: [M]?
}

/// options: musicArtist, musicTrack, album, musicVideo, mix, song.
/// https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/Searching.html#//apple_ref/doc/uid/TP40017632-CH5-SW2
extension MusicModel.MediaType {
    func entityKey() -> String {
        switch self {
        case .album:
            return "album"
        case .artist:
            return "musicArtist"
        case .song:
            return "song"
        default:
            return ""
        }
    }
}
enum iTunesAPI {
    case search(String, Set<MusicModel.MediaType>, Int)
}
extension iTunesAPI: APIable {
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }

    var method: String {
        switch self {
        case .search:
            return "GET"
        }
    }

    var queryData: [URLQueryItem] {
        var items: [URLQueryItem] = []
        switch self {
        case let .search(text, typs, offset):
            /// Note: URL encoding replaces spaces with the plus (+) character and all characters except the following are encoded: letters, numbers, periods (.), dashes (-), underscores (_), and asterisks (*).
            let term = text.components(separatedBy: " ")
            let termItem = URLQueryItem(name: "term", value: term.joined(separator: "+"))

            let offsetItem = URLQueryItem(name: "offset", value: "\(offset)")

            let entityStr = typs.map { $0.entityKey() }
                .joined(separator: ",")
            let entityItem = URLQueryItem(name: "entity", value: entityStr)

            items.append(contentsOf: [termItem, offsetItem, entityItem])
        }

        let region = NSLocale.current.identifier
        let country = region.suffix(2).description
        let langItem = URLQueryItem(name: "lang", value: region)
        let countryItem = URLQueryItem(name: "country", value: country)
        // The media type you want to search for. For example: movie or music
        let mediaItem = URLQueryItem(name: "media", value: "music")

        // default pagesize: 20
        let limitItem = URLQueryItem(name: "limit", value: "20")
        items.append(contentsOf: [langItem, countryItem, mediaItem, limitItem])

        return items
    }

//    var bodyData: [String: Codable] {
//        return [:]
//    }
//    var headerData:[String:String]{
//        return [:]
//    }
    var request: URLRequest? {
        guard var components = URLComponents(string: iTunesHost) else {
            assertionFailure("iTunesAPI: iTunesHost Error")
            return nil
        }
        components.path = path
        components.queryItems = queryData
        guard let url = components.url else {
            assertionFailure("iTunesAPI: Url error")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
