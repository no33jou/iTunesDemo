//
//  BookM.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Foundation

class BookmarkViewModel{
    var data:[MusicModel] = []
    
    func loadData(){
        let data = UserDefaultDataStore.shared.get(key: .bookmark([])) as? [MusicModel]
        self.data = data ?? []
    }
    func syncData(){
        UserDefaultDataStore.shared.update(item: .bookmark(self.data))
    }
    func insert(song:MusicModel){
        self.data.append(song)
        
        syncData()
    }
    func remove(song:MusicModel) {
        data = data.filter { $0.trackId != song.trackId }
        
        syncData()
    }
    
}
