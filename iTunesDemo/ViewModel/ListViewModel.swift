//
//  ListViewModel.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/3.
//

import Foundation
import Combine
class ListViewModel<T> {
    var limit:Int = 20
    var listCount:Int = 0
    var list:[T] = []
    enum DataState {
        case normal
        case empty
        case noMore
        // 错误：网络错误、数据结构错误
        case error
        case loading
    }
   @Published var state:DataState = .normal
    var task:AnyCancellable?
    func resetData() {
        list = []
        state = .normal
        listCount = 0
        task?.cancel()
        task = nil
    }
    func inset(results:[T]){
        // 无数据
        if results.isEmpty && list.isEmpty {
            state = .empty
            return
        }
        // 无更多数据
        if results.isEmpty && !list.isEmpty{
            state = .noMore
            return
        }
        state = .normal
        list.append(contentsOf: results)
        listCount = list.count
    }
    func fetchData() {
        resetData()
        state = .loading
    }
    func fetchMoreData(){
        state = .loading
        task?.cancel()
        task = nil
    }
}
