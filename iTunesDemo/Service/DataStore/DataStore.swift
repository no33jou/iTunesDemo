//
//  DataStore.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/7.
//

import Foundation
/// Key-Value存储服务
/// 使用方式：
/// BookmarkKind.whereStore(.userDefault).update(data: data)
/// BookmarkKind.whereStore(.userDefault).get()
/// BookmarkKind.whereStore(.userDefault).remove()
///
/// DataKindable用来指定 数据类型 和 存储标识（key）
/// StoreKind是用来快速获取存储方式

/// 存储方式
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

/// 收藏夹
struct BookmarkKind: DataKindable {
    static var key = "bookmark"
    typealias T = [MusicModel]
}
