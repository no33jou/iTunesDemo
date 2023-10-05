//
//  DataStoreProtocol.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Foundation

enum DataStoreKind{
    case bookmark([MusicModel])
    
    var key:String {
        switch self {
        case .bookmark:
            return "bookmark"
        default:
            assertionFailure("DataStoreKind \(self): No Key define!")
            return ""
        }
    }
    var value:Codable{
        switch self{
        case let .bookmark(data):
            return data
        default:
            assertionFailure("DataStoreKind \(self):No Value define!")
        }
    }
}
protocol DataStore {
    func update(item: DataStoreKind)
    func remove(item: DataStoreKind)
    func get(key: DataStoreKind) -> Codable?
}
