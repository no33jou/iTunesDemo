//
//  SearchViewModelUseCase.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/6.
//

import Foundation
import Combine

struct SearchViewModelUseCase: SearchViewModelCaseType {
    func searchMusic(keyword: String, medias: [MusicModel.MediaType], offset: Int) -> AnyPublisher<iTunesResponseResult<MusicModel>, APIFailure>? {
        iTunesAPI.search(keyword, medias, offset)
            .fetch(type: iTunesResponseResult<MusicModel>.self)
    }
    
    func loadBookmark() -> [MusicModel] {
        let data = BookmarkKind.whereStore(.userDefault).get() ?? []
        return data
    }
    
    func updateBookmark(_ list: [MusicModel]) {
        BookmarkKind.whereStore(.userDefault).update(data: list)
    }
}
