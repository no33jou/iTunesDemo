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
        }
    }
    @Published var displayData:[SongCellViewModel] = []
    
    func loadData(){
        let data:[MusicModel] = UserDefaultDataStore.shared.get(key: .bookmark([])) ?? []
        self.data = data
    }
    func syncData(){
        UserDefaultDataStore.shared.update(item: .bookmark(self.data))
    }
    
    func remove(index:Int){
        data.remove(at: index)
        
        syncData()
    }
}
