//
//  BookM.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Foundation
protocol BookmarkViewModelCaseType {
    func fetchBookmarkData() -> [MusicModel]
    func updateBookmarkData(_ data:[MusicModel])
}

class BookmarkViewModel{
    let useCase:BookmarkViewModelCaseType
    @Published var displayData:[SongCellViewModel] = []
    
    private var data:[MusicModel] = []{
        didSet{
            displayData = data.map { SongCellViewModel($0) }.map({ v in
                var vm = v
                vm.isBookmark = true
                return vm
            })
        }
    }
    
    init(_ useCase: BookmarkViewModelCaseType) {
        self.useCase = useCase
    }
    func loadData(){
        data = useCase.fetchBookmarkData()
    }
    func syncData(){
        useCase.updateBookmarkData(data)
    }
    
    func remove(index:Int){
        data.remove(at: index)
        syncData()
    }
}
