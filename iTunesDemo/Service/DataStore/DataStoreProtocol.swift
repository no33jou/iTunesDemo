//
//  DataStoreProtocol.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Foundation

protocol DataKindable{
    associatedtype T:Codable
    static var key:String { get }
}

protocol StorableMethod {
    func update<T:Codable>(key:String,data: T)
    func remove(key: String)
    func get<T:Codable>(key: String) -> T?
}
struct DataStoreService<T:Codable>{
    let key:String
    let store:StorableMethod
    init(key: String, store: StorableMethod) {
        self.key = key
        self.store = store
    }
    func update(data:T){
        store.update(key: key, data: data)
    }
    func remove(){
        store.remove(key: key)
    }
    func get()->T?{
        store.get(key: key)
    }
}
extension DataKindable{
   static func whereStore(_ store: StorableMethod) -> DataStoreService<T>{
        let service = DataStoreService<T>(key: key, store:store)
        return service
    }
}
