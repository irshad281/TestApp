//
//  PersistantManager.swift
//  TestApp
//
//  Created by Irshad Ahmad on 07/06/23.
//

import Foundation

struct PersistantManager {
    private enum Keys: String {
        case joke
    }
    
    static func saveJokes(_ jokes: [String]) {
        let data = try? JSONEncoder().encode(jokes)
        UserDefaults.standard.setValue(data, forKey: Keys.joke.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func fetchJokes() -> [String] {
        if let data = UserDefaults.standard.value(forKey: Keys.joke.rawValue) as? Data {
            let jokes = try? JSONDecoder().decode([String].self, from: data)
            return jokes ?? []
        }
        return []
    }
}
