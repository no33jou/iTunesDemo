//
//  BookM.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Foundation

class BookmarkViewModel{
    var data:[MusicModel] = []{
        didSet{
            displayData = data.map { SongCellViewModel($0) }.map({ v in
                var vm = v
                vm.isBookmark = true
                return vm
            })
//            let artis = Set(data.map({$0.trackId}))
        }
    }
    @Published var displayData:[SongCellViewModel] = []
    
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
    func remove(index:Int){
        data.remove(at: index)
        
        syncData()
    }
    func remove(song:MusicModel) {
        data = data.filter { $0.trackId != song.trackId }
        
        syncData()
    }
    
}
