//
//  UserDefaultDataStore.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Foundation

class UserDefaultDataStore{
    let shared = UserDefaultDataStore()
    private init(){
    }
    
    func update(item: DataStoreKind){
        let key = item.key
        UserDefaults().setValue(item.value, forKey: key)
    }
    func remove(item: DataStoreKind){
        UserDefaults().removeObject(forKey: item.key)
    }
    func get<T:Codable>(item: DataStoreKind) -> T?{
        return UserDefaults().object(forKey: item.key) as? T
    }
}
