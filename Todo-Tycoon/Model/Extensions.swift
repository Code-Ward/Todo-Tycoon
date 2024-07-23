//
//  Extensions.swift
//  Todo-Tycoon
//
//  Created by 황석현 on 7/23/24.
//

import Foundation

extension UserDefaults {
    
    /// Todo 저장
    func setObject<T: Codable>(_ object: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            self.set(encoded, forKey: key)
        }
    }
    
    /// Todo 불러오기
    func getObject<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: data)
        }
        return nil
    }
}
