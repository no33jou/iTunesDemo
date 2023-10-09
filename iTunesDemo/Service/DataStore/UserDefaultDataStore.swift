//
//  UserDefaultDataStore.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Foundation

class UserDefaultDataStore:StorableMethod{
    static let shared = UserDefaultDataStore()
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    private init(){
    }
    func update<T:Codable>(key:String,data: T){
        guard let d = try? encoder.encode(data) else{return}
        UserDefaults.standard.setValue(d, forKey: key)
    }
    func remove(key: String){
        UserDefaults().removeObject(forKey: key)
    }
    func get<T:Codable>(key: String) -> T?{
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        let model = try? decoder.decode(T.self, from: data)
        return model
    }
}
