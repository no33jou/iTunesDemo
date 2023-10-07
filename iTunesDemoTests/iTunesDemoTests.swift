//
//  iTunesDemoTests.swift
//  iTunesDemoTests
//
//  Created by yaojunren on 2023/10/3.
//

import XCTest
@testable import iTunesDemo
import Combine
let song1 = """
{
  "wrapperType": "track",
  "kind": "song",
  "artistId": 300117743,
  "collectionId": 311168984,
  "trackId": 311169031,
  "artistName": "周杰倫",
  "collectionName": "魔杰座",
  "trackName": "說好的幸福呢",
  "collectionCensoredName": "魔杰座",
  "trackCensoredName": "說好的幸福呢",
  "artistViewUrl": "https://music.apple.com/hk/artist/%E5%91%A8%E6%9D%B0%E5%80%AB/300117743?uo=4",
  "collectionViewUrl": "https://music.apple.com/hk/album/%E8%AA%AA%E5%A5%BD%E7%9A%84%E5%B9%B8%E7%A6%8F%E5%91%A2/311168984?i=311169031&uo=4",
  "trackViewUrl": "https://music.apple.com/hk/album/%E8%AA%AA%E5%A5%BD%E7%9A%84%E5%B9%B8%E7%A6%8F%E5%91%A2/311168984?i=311169031&uo=4",
  "previewUrl": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/04/2c/af/042caf55-d9ae-21e8-f3ef-637455a40d9b/mzaf_10937625040209181184.plus.aac.p.m4a",
  "artworkUrl30": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/ad/58/da/ad58da0d-b971-fc94-e4c4-72b0d194dcc8/mzi.ajgzxulu.jpg/30x30bb.jpg",
  "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/ad/58/da/ad58da0d-b971-fc94-e4c4-72b0d194dcc8/mzi.ajgzxulu.jpg/60x60bb.jpg",
  "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/ad/58/da/ad58da0d-b971-fc94-e4c4-72b0d194dcc8/mzi.ajgzxulu.jpg/100x100bb.jpg",
  "collectionPrice": 73,
  "trackPrice": 8,
  "releaseDate": "2008-10-14T07:00:00Z",
  "collectionExplicitness": "notExplicit",
  "trackExplicitness": "notExplicit",
  "discCount": 1,
  "discNumber": 1,
  "trackCount": 11,
  "trackNumber": 6,
  "trackTimeMillis": 254720,
  "country": "HKG",
  "currency": "HKD",
  "primaryGenreName": "國語流行樂",
  "isStreamable": true
}
""".data(using: .utf8)
let song2 = """
{
  "wrapperType": "track",
  "kind": "song",
  "artistId": 300117743,
  "collectionId": 1119071949,
  "trackId": 1119072024,
  "artistName": "周杰倫",
  "collectionName": "周杰倫的床邊故事",
  "trackName": "告白氣球",
  "collectionCensoredName": "周杰倫的床邊故事",
  "trackCensoredName": "告白氣球",
  "artistViewUrl": "https://music.apple.com/hk/artist/%E5%91%A8%E6%9D%B0%E5%80%AB/300117743?uo=4",
  "collectionViewUrl": "https://music.apple.com/hk/album/%E5%91%8A%E7%99%BD%E6%B0%A3%E7%90%83/1119071949?i=1119072024&uo=4",
  "trackViewUrl": "https://music.apple.com/hk/album/%E5%91%8A%E7%99%BD%E6%B0%A3%E7%90%83/1119071949?i=1119072024&uo=4",
  "previewUrl": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/1d/93/4a/1d934adb-11f3-d8c8-ddf9-b612e7582c7d/mzaf_8053542949547112070.plus.aac.p.m4a",
  "artworkUrl30": "https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/10/47/bc/1047bc94-9178-5ba5-b789-ab8e1ab4adb7/dj.htgbczgv.jpg/30x30bb.jpg",
  "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/10/47/bc/1047bc94-9178-5ba5-b789-ab8e1ab4adb7/dj.htgbczgv.jpg/60x60bb.jpg",
  "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/10/47/bc/1047bc94-9178-5ba5-b789-ab8e1ab4adb7/dj.htgbczgv.jpg/100x100bb.jpg",
  "collectionPrice": 73,
  "trackPrice": 8,
  "releaseDate": "2016-06-24T12:00:00Z",
  "collectionExplicitness": "notExplicit",
  "trackExplicitness": "notExplicit",
  "discCount": 1,
  "discNumber": 1,
  "trackCount": 10,
  "trackNumber": 8,
  "trackTimeMillis": 215590,
  "country": "HKG",
  "currency": "HKD",
  "primaryGenreName": "國語流行樂",
  "isStreamable": true
}
""".data(using: .utf8)
let movieJson = """
{
  "wrapperType": "track",
  "kind": "feature-movie",
  "trackId": 1048880523,
  "artistName": "林嶺東",
  "trackName": "迷城",
  "trackCensoredName": "迷城",
  "trackViewUrl": "https://itunes.apple.com/hk/movie/%E8%BF%B7%E5%9F%8E/id1048880523?uo=4",
  "previewUrl": "https://video-ssl.itunes.apple.com/itunes-assets/Video118/v4/e9/09/c0/e909c0f9-f3dd-9e23-79f2-eb22bb3eb40d/mzvf_3523158631661465191.640x362.h264lc.U.p.m4v",
  "artworkUrl30": "https://is1-ssl.mzstatic.com/image/thumb/Video2/v4/63/48/68/634868ba-5077-da1c-c0c3-7eb16ffbeb12/pr_source.lsr/30x30bb.jpg",
  "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Video2/v4/63/48/68/634868ba-5077-da1c-c0c3-7eb16ffbeb12/pr_source.lsr/60x60bb.jpg",
  "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Video2/v4/63/48/68/634868ba-5077-da1c-c0c3-7eb16ffbeb12/pr_source.lsr/100x100bb.jpg",
  "collectionPrice": 118,
  "trackPrice": 118,
  "trackRentalPrice": 38,
  "collectionHdPrice": 158,
  "trackHdPrice": 158,
  "trackHdRentalPrice": 38,
  "releaseDate": "2015-08-20T07:00:00Z",
  "collectionExplicitness": "notExplicit",
  "trackExplicitness": "notExplicit",
  "trackTimeMillis": 6091455,
  "country": "HKG",
  "currency": "HKD",
  "primaryGenreName": "動作歷險",
  "contentAdvisoryRating": "第II類",
  "longDescription": "天明（古天樂飾）離開警隊後，開了一間酒吧，某夜邂逅醉酒的小雲（佟麗婭飾），隨即發現自己成為小雲前度男友的追擊目標。原來小雲的前度男友是一名極具勢力的律師，更僱用了一班來自台灣的匪徒（張孝全飾）對付小雲及不明所以的天明。不學無術的弟弟（余文樂飾）本欲幫小雲脫險，卻因一時貪念拿取了小雲的一箱賄款，爆發連場追擊，更令天明無辜捲入黑社會及警察互相廝殺的漩渦當中，而隱藏背後的勢力亦逐漸浮現…"
}
""".data(using: .utf8)
let ablumJson = """
{
  "wrapperType": "collection",
  "collectionType": "Album",
  "artistId": 1154054707,
  "collectionId": 1645047495,
  "artistName": "周深",
  "collectionName": "花开忘忧 - Single",
  "collectionCensoredName": "花开忘忧 - Single",
  "artistViewUrl": "https://music.apple.com/hk/artist/%E5%91%A8%E6%B7%B1/1154054707?uo=4",
  "collectionViewUrl": "https://music.apple.com/hk/album/%E8%8A%B1%E5%BC%80%E5%BF%98%E5%BF%A7-single/1645047495?uo=4",
  "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Music122/v4/29/41/89/2941894d-965e-e897-88ea-52d38d7fea3b/cover.jpg/60x60bb.jpg",
  "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music122/v4/29/41/89/2941894d-965e-e897-88ea-52d38d7fea3b/cover.jpg/100x100bb.jpg",
  "collectionPrice": 5,
  "collectionExplicitness": "notExplicit",
  "trackCount": 1,
  "copyright": "℗ 2022 上海劲焱文化传媒有限公司",
  "country": "HKG",
  "currency": "HKD",
  "releaseDate": "2022-09-10T07:00:00Z",
  "primaryGenreName": "國語流行樂"
}
""".data(using: .utf8)
let artJson = """
{
  "wrapperType": "artist",
  "artistType": "Artist",
  "artistName": "周深",
  "artistLinkUrl": "https://music.apple.com/hk/artist/%E5%91%A8%E6%B7%B1/1154054707?uo=4",
  "artistId": 1154054707,
  "primaryGenreName": "國語流行樂",
  "primaryGenreId": 1253
}
""".data(using: .utf8)

struct BookmarkViewModelTestCase: BookmarkViewModelCaseType {
    func fetchBookmarkData() -> [MusicModel] {
        guard let data = song1 else { return [] }
        guard let music = try? JSONDecoder().decode(MusicModel.self, from: data)else { return [] }
        return [music]
    }
    
    func updateBookmarkData(_ data: [MusicModel]) {
        print(data)
    }
}
struct SearchViewModelTestCase: SearchViewModelCaseType {
    let list:[MusicModel]
    let bookmark:[MusicModel]
    func searchMusic(keyword: String, medias: [iTunesDemo.MusicModel.MediaType], offset: Int) -> AnyPublisher<iTunesDemo.iTunesResponseResult<iTunesDemo.MusicModel>, iTunesDemo.APIFailure>? {
        let result = iTunesResponseResult(resultCount: list.count, results: list)
        
        let pulicsher = CurrentValueSubject<iTunesResponseResult<MusicModel>, APIFailure>(result).eraseToAnyPublisher()
        return pulicsher
    }
    
    func loadBookmark() -> [iTunesDemo.MusicModel] {
        
        return bookmark
    }
    
    func updateBookmark(_ list: [iTunesDemo.MusicModel]) {
        print(list)
    }
    
    
}
final class iTunesDemoTests: XCTestCase {
    var s1:MusicModel?
    var s2:MusicModel?
    var ablum:MusicModel?
    var artist:MusicModel?
    var movie:MusicModel?
    override func setUpWithError() throws {
//        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        s1 = try! decoder.decode(MusicModel.self, from: song1!)
        s2 = try! decoder.decode(MusicModel.self, from: song2!)
        ablum = try! decoder.decode(MusicModel.self, from: ablumJson!)
        artist = try! decoder.decode(MusicModel.self, from: artJson!)
//        movie = try! decoder.decode(MusicModel.self, from: movieJson!)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSongViewModel() throws{
        guard let s1 = self.s1 else { return  }
        var viewModel = SongCellViewModel(s1)
        
        // 正确
        XCTAssertEqual(viewModel.title , s1.trackName)
        XCTAssertEqual(viewModel.detail ?? "" ,"\(Localiz.Search.song.str) · \(s1.artistName!)")
        XCTAssertEqual(viewModel.viewURL,URL(string: s1.trackViewUrl!))
        XCTAssertEqual(viewModel.imageUrl,URL(string:s1.artworkUrl100!))
        XCTAssertNotNil(viewModel.actionItem)
        
        if case let .button(image) = viewModel.actionItem {
            XCTAssert(image == UIImage(systemName: "star"))
        }else{
            XCTAssert(false, "xxx")
        }
        
        viewModel.isBookmark = true
        if case let .button(image) = viewModel.actionItem {
            XCTAssert(image == UIImage(systemName: "star.fill"))
        }else{
            XCTAssert(false, "xxx")
        }
        //错误
    }
    func testAblumViewModel() throws{
        guard let album = self.ablum else { return }
        let vm = AlbumCellViewModel(album)
        XCTAssertEqual(vm.title , album.collectionName)
        XCTAssertEqual(vm.detail ?? "" ,"\(Localiz.Search.album.str) · \(album.artistName!)")
        XCTAssertEqual(vm.viewURL,URL(string: album.collectionViewUrl!))
        XCTAssertEqual(vm.imageUrl,URL(string:album.artworkUrl100!))
        
    }
    func testArtistViewModel() throws {
        guard let art = self.artist else { return }
        let vm = ArtistCellViewModel(art)
        XCTAssertEqual(vm.title , art.artistName)
        XCTAssertNil(vm.detail)
        XCTAssertEqual(vm.viewURL, URL(string: art.artistLinkUrl!))
        XCTAssertNil(vm.imageUrl)
    }
    func testBookmarkViewModel() throws {
        let viewModel = BookmarkViewModel(BookmarkViewModelTestCase())
        // 获取数据
        viewModel.loadData()
        
        //检查显示数据
        guard let songViewModel = viewModel.displayData.first else {
            XCTAssert(false, "错误：展示数据为空")
            return
        }
        XCTAssert(songViewModel.isBookmark == true, "错误：展示数据都应该为搜藏类型")
        
        //移除
        viewModel.remove(index: 0)
        XCTAssert(viewModel.displayData.isEmpty, "数据应该为空")
    }
    func testSearchViewModel() throws {
        guard let song1 = s1,
        let song2 = s2,
        let album = ablum,
        let artist = artist
//        let movie = movie
        else { return }
        let list = [song1,song2,album,artist]
        let bookmark = [song1]
        let viewModel = SearchViewModel(useCase: SearchViewModelTestCase(list: list, bookmark: bookmark))
        
        viewModel.keywords = "zhou"
        // 检查数据
        XCTAssert(viewModel.displayList.isEmpty)
        viewModel.fetchData()
        XCTAssert(viewModel.displayList.count == list.count)
    
        // 测试筛选
        XCTAssert(viewModel.showFilters.count == list.count)
        // 选择全部
        viewModel.indexOfSelectedFilter = 0
        XCTAssertNil(viewModel.selectMediaType)
        XCTAssert(viewModel.displayList.count == list.count)
        // 选择其他
        viewModel.indexOfSelectedFilter = 1
        XCTAssertNotNil(viewModel.selectMediaType)
        XCTAssert(viewModel.selectMediaType == viewModel.filters[0])
        XCTAssert(viewModel.displayList.count > 0 && viewModel.displayList.count < list.count)
        
        let count = viewModel.displayList.count
        // 选择其他类型时不能加载数据
        viewModel.fetchMoreData()
        XCTAssert(viewModel.displayList.count == count)
        
        // 收藏
        viewModel.loadBookmark()
        viewModel.indexOfSelectedFilter = 0
        
        let trackId = bookmark.first?.trackId ?? 0
        XCTAssert(viewModel.idsOfBoolmark.contains(bookmark.first?.trackId ?? 0))
        XCTAssert(viewModel.listOfBookmark.contains(where: { $0.trackId == trackId }))
        XCTAssert(viewModel.displayList.contains(where: { vm in
            if let v = vm as? SongCellViewModel,
               v.data.trackId == trackId,
               v.isBookmark{
                return true
            }
            return false
        }))
        // 插入收藏
        viewModel.insetBookmark(song2)
        XCTAssert(viewModel.idsOfBoolmark.count == 2)
        XCTAssert(viewModel.listOfBookmark.contains(where: { $0.trackId == song2.trackId }))
        // 移除
        viewModel.removeBookmark(song2.trackId ?? 0)
        XCTAssert(viewModel.idsOfBoolmark.contains(bookmark.first?.trackId ?? 0))
        XCTAssert(viewModel.listOfBookmark.contains(where: { $0.trackId == trackId }))
        XCTAssert(viewModel.displayList.contains(where: { vm in
            if let v = vm as? SongCellViewModel,
               v.data.trackId == trackId,
               v.isBookmark{
                return true
            }
            return false
        }))
        
        // 加载数据
        viewModel.fetchMoreData()
        XCTAssert(viewModel.displayList.count == list.count * 2)
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
