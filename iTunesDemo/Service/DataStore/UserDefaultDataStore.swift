//
//  UserDefaultDataStore.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Foundation

class UserDefaultDataStore{
    static let shared = UserDefaultDataStore()
    private init(){
    }
    
    func update(item: DataStoreKind){
        let key = item.key
        UserDefaults().setValue(item.value, forKey: key)
    }
    func remove(item: DataStoreKind){
        UserDefaults().removeObject(forKey: item.key)
    }
    func get(key: DataStoreKind) -> Codable?{
        return UserDefaults().object(forKey: key.key) as? Codable
    }
}
