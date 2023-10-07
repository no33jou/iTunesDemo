//
//  SearchViewModel.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/4.
//

import Combine
import Foundation

protocol SearchViewModelCaseType {
    func searchMusic(keyword:String,medias:[MusicModel.MediaType],offset:Int) -> AnyPublisher<iTunesResponseResult<MusicModel>,APIFailure>?
    func loadBookmark()->[MusicModel]
    func updateBookmark(_ list:[MusicModel])
}

extension MusicModel.MediaType{
    func filterString() -> String {
        switch self {
        case .artist:
            return Localiz.Search.artist.str
        case .song:
            return Localiz.Search.song.str
        case .album:
            return Localiz.Search.album.str
        case .unowned:
            return "unowned"
        }
    }
}
class SearchViewModel: ListViewModel<MusicModel>, ObservableObject {
    let useCase:SearchViewModelCaseType
    init(useCase: SearchViewModelCaseType) {
        self.useCase = useCase
    }
    // MARK: - List property
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
            
            list.insert(Localiz.Search.all.str, at: 0)
            self.showFilters = list
        }
    }

    var keywords: String?
    /// 目前只支持全部媒体类型搜索
    let mediaTypes = MusicModel.MediaType.all
    
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
    // MARK: - Bookmark property
    var listOfBookmark:[MusicModel] = []{
        didSet{
            idsOfBoolmark = Set(listOfBookmark.map({ $0.trackId ?? 0 }))
        }
    }
    var idsOfBoolmark:Set<Int> = []
    
    // MARK: - Alert
    let alertPublisher = PassthroughSubject<String,Never>()
    // MARK: - Search Network
    override func fetchData() {
        super.fetchData()
        
        guard let keywords = keywords else { return }
        showLoading = true
        let api = useCase.searchMusic(keyword: keywords, medias: mediaTypes, offset: listCount)
        
        task = api?.sink(receiveCompletion: { [weak self] completion in
            guard let this = self else { return }
            this.showLoading = false
            switch completion {
            case let .failure(fail):
                this.state = .error
                this.alertFromNetowork(error: fail)
            default:
                break
            }
        }, receiveValue: { [weak self] result in
            guard let this = self else { return }
            this.inset(results: result.results ?? [])
        })
    }

    override func fetchMoreData() {
        if state != .normal && state != .error {
            return
        }
        if self.selectMediaType != nil{
            return
        }
        super.fetchMoreData()
        guard let keywork = keywords else { return }
        task = useCase.searchMusic(keyword: keywork, medias: MusicModel.MediaType.all, offset:listCount)?
            .sink(receiveCompletion: { [weak self] completion in
                guard let this = self else { return }
                switch completion {
                case let .failure(fail):
                    this.state = .error
                    this.alertFromNetowork(error: fail)
                default:
                    break
                }
            }, receiveValue: { [weak self] result in
                guard let this = self else { return }
                this.inset(results: result.results ?? [])
            })
    }
    func alertFromNetowork(error: APIFailure){
        switch error {
        case .network:
            alertPublisher.send(Localiz.Alert.networkError.str)
        default:
            alertPublisher.send(Localiz.Alert.unownedError.str)
        }
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
// MARK: - Bookmark Func
extension SearchViewModel{
    func loadBookmark() {
        listOfBookmark = useCase.loadBookmark()
    }
    func insetBookmark(_ model:MusicModel){
        if model.mediaType != .song {
            return
        }
        if idsOfBoolmark.contains(model.trackId ?? 0){
            return
        }
        listOfBookmark.append(model)
        useCase.updateBookmark(listOfBookmark)
        refreshDisplayList()
    }
    func removeBookmark(_ id:Int){
        if !idsOfBoolmark.contains(id){
            return
        }
        listOfBookmark.removeAll { $0.trackId == id }
        useCase.updateBookmark(listOfBookmark)
        refreshDisplayList()
    }
}
