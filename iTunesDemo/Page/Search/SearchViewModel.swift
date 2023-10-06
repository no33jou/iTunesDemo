//
//  SearchViewModel.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/4.
//

import Combine
import Foundation


extension MusicModel.MediaType{
    func filterString() -> String {
        switch self {
        case .artist:
            return Localiz.Search.artist.stringFromLocal()
        case .song:
            return Localiz.Search.song.stringFromLocal()
        case .album:
            return Localiz.Search.album.stringFromLocal()
        case .unowned:
            return "unowned"
        }
    }
}
class SearchViewModel: ListViewModel<MusicModel>, ObservableObject {
    override var list: [MusicModel] {
        didSet {
            refreshDisplayList()
            filters = Set(list.map { $0.mediaType }).map({ $0 })
        }
    }

    var filters: [MusicModel.MediaType] = [] {
        didSet {
            indexOfSelectedFilter = 0
            if filters.isEmpty {
                self.showFilters = []
                return
            }
            
            var list = filters.map { type in
                type.filterString()
            }
            
            list.insert(Localiz.Search.all.stringFromLocal(), at: 0)
            self.showFilters = list
        }
    }

    var keywork: String?
    /// 目前只支持全部媒体类型搜索
    let mediaTypes = MusicModel.MediaType.all()
    
    @Published var showLoading = false
    var displayPublisher = PassthroughSubject<Void, Never>()
    var displayList: [MusicCellViewModel] = []{
        didSet{
            displayPublisher.send()
        }
    }
    
    /// 当前数据支持的 筛选媒体类型文本集
    @Published var showFilters: [String] = []
    /// 选择 筛选的下标， 默认值为0 即全部
    var indexOfSelectedFilter:Int = 0{
        didSet{
            if indexOfSelectedFilter == 0{
                selectMediaType = nil
                return
            }
           selectMediaType = filters[indexOfSelectedFilter - 1]
        }
    }
    /// 选择的媒体类型
    var selectMediaType: MusicModel.MediaType?{
        didSet{
            refreshDisplayList()
        }
    }
    
    var listOfBookmark:[MusicModel] = []{
        didSet{
            idsOfBoolmark = Set(listOfBookmark.map({ $0.trackId ?? 0 }))
        }
    }
    var idsOfBoolmark:Set<Int> = []
    
    override func fetchData() {
        super.fetchData()
        
        guard let keywork = keywork else { return }
        showLoading = true
        let api = iTunesAPI.search(keywork, mediaTypes, 0)
            .fetch(type: iTunesResponseResult<MusicModel>.self)
        
        task = api?.sink(receiveCompletion: { [weak self] completion in
            guard let this = self else { return }
            this.showLoading = false
            switch completion {
            case let .failure(fail):
                this.state = .error
                print(fail)
            default:
                break
            }
        }, receiveValue: { [weak self] result in
            guard let this = self else { return }
            this.inset(results: result.results ?? [])
        })
    }

    override func fetchMoreData() {
        super.fetchMoreData()
        guard let keywork = keywork else { return }
        task = iTunesAPI.search(keywork, mediaTypes, listCount)
            .fetch(type: iTunesResponseResult<MusicModel>.self)?
            .sink(receiveCompletion: { [weak self] completion in
                guard let this = self else { return }
                switch completion {
                case let .failure(fail):
                    this.state = .error
                    print(fail)
                default:
                    break
                }
            }, receiveValue: { [weak self] result in
                guard let this = self else { return }
                this.inset(results: result.results ?? [])
            })
    }

    func refreshDisplayList() {
        
        var list = self.list
        if let filterType = selectMediaType {
            list = list.filter { $0.mediaType == filterType }
        }
        list = list.filter({ $0.mediaType != .unowned  })
        let displayData:[MusicCellViewModel] = list.map { model in
            switch model.mediaType {
            case .artist:
                return ArtistCellViewModel(model)
            case .song:
                var vm = SongCellViewModel(model)
                vm.isBookmark = idsOfBoolmark.contains(model.trackId ?? 0)
                return vm
            case .album:
                return AlbumCellViewModel(model)
            case .unowned:
                assertionFailure("MusicModel to MusicCellViewModel Fail")
                return SongCellViewModel(model)
            }
        }
        self.displayList = displayData
    }
}
// MARK: - Bookmark
extension SearchViewModel{
    func loadBookmark() {
        listOfBookmark = UserDefaultDataStore.shared.get(key: .bookmark([])) ?? []
    }
    func insetBookmark(_ model:MusicModel){
        if model.mediaType != .song {
            return
        }
        if idsOfBoolmark.contains(model.trackId ?? 0){
            return
        }
        listOfBookmark.append(model)
        UserDefaultDataStore.shared.update(item: .bookmark(listOfBookmark))
        refreshDisplayList()
    }
    func removeBookmark(_ id:Int){
        if !idsOfBoolmark.contains(id){
            return
        }
        listOfBookmark.removeAll { $0.trackId == id }
        UserDefaultDataStore.shared.update(item: .bookmark(listOfBookmark))
        refreshDisplayList()
    }
}
