//
//  UserDefaultDataStore.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Foundation

class UserDefaultDataStore{
    
    static let shared = UserDefaultDataStore()
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    private init(){
    }
    
    func update(item: DataStoreKind){
        let key = item.key
        guard let data = try? encoder.encode(item.value) else{return}
        UserDefaults.standard.setValue(data, forKey: key)
    }
    func remove(item: DataStoreKind){
        UserDefaults().removeObject(forKey: item.key)
    }
    func get<T:Codable>(key: DataStoreKind) -> T?{
        guard let data = UserDefaults.standard.value(forKey: key.key) as? Data else { return nil }
        let list = try? decoder.decode(T.self, from: data)
        return list
    }
}
