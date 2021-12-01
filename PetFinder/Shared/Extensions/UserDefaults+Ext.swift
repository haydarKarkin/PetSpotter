//
//  UserDefaults+Ext.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//
import Foundation

// MARK: Codable Extension

extension UserDefaults {
    func set<Element: Codable>(value: Element, forKey key: String) {
        let data = try? JSONEncoder().encode(value)
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    func codable<Element: Codable>(forKey key: String) -> Element? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        let element = try? JSONDecoder().decode(Element.self, from: data)
        return element
    }
}

// MARK: Keys

extension UserDefaults {
    enum Keys: String {
        case token
    }
}
