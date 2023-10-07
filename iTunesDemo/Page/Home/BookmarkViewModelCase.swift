//
//  BookmarkViewModelCase.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/6.
//

import Foundation

struct BookmarkViewModelCase: BookmarkViewModelCaseType {
    func fetchBookmarkData() -> [MusicModel] {
        let data = BookmarkKind.whereStore(.userDefault).get() ?? []
        return data
    }
    
    func updateBookmarkData(_ data: [MusicModel]) {
        BookmarkKind.whereStore(.userDefault).update(data: data)
    }
}

