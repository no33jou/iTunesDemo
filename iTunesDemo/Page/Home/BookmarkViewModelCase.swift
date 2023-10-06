//
//  BookmarkViewModelCase.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/6.
//

import Foundation

struct BookmarkViewModelCase: BookmarkViewModelCaseType {
    func fetchBookmarkData() -> [MusicModel] {
        let data:[MusicModel] = UserDefaultDataStore.shared.get(key: .bookmark([])) ?? []
        return data
    }
    
    func updateBookmarkData(_ data: [MusicModel]) {
        UserDefaultDataStore.shared.update(item: .bookmark(data))
    }
}

