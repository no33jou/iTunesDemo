//
//  DataStore.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/7.
//

import Foundation

enum StoreKind {
    case userDefault

    var store: DataStoreable {
        switch self {
        case .userDefault:
            return UserDefaultDataStore.shared
        }
    }
}

extension DataKindable {
    static func whereStore(_ store: StoreKind) -> DataStoreService<T> {
        let service = DataStoreService<T>(key: key, store: store.store)
        return service
    }
}
struct BookmarkKind: DataKindable {
    static var key = "bookmark"
    typealias T = [MusicModel]
}
