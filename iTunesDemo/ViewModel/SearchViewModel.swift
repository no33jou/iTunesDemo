//
//  SearchViewModel.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/4.
//

import Combine
import Foundation
class SearchViewModel: ListViewModel<MusicModel>, ObservableObject {
    override var list: [MusicModel] {
        didSet {
            refreshDisplayList()
            filters = Set(list.map { $0.mediaType })
        }
    }

    var filters: Set<MusicModel.MediaType> = [] {
        didSet {
            if filters.isEmpty {
                showFilters = []
                return
            }
            
//            var list = filters.map { type in
//                type.localString()
//            }
//            list.insert(Local.Search.all.rawValue, at: 0)
//            showFilters = list
        }
    }

    var keywork: String?
    /// 目前只支持全部媒体类型搜索
    let mediaTypes = MusicModel.MediaType.all()
    
    @Published var showLoading = false
    @Published var displayList: [MusicCellViewModel] = []
    /// 当前数据支持的筛选类型
    @Published var showFilters: [String] = []
    /// 选择 筛选的下标， 默认值为0 即全部
    var selectIndexOfFilter:Int = 0{
        didSet{
            if selectIndexOfFilter == 0{
                selectMediaType = nil
                return
            }
        }
    }
    /// 选择的媒体类型
    var selectMediaType: MusicModel.MediaType?
    
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
        self.selectIndexOfFilter = 0
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
                return SongCellViewModel(model)
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
