//
//  Environment.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

enum EnvType: String {
    case debug = "DEBUG"
    case release = "RELEASE"
}

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let rootURL = "ROOT_URL"
            static let envName = "ENV_TYPE"
            static let apiKey = "API_KEY"
            static let secret = "SECRET"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let rootURL: URL = {
        guard let rootURLString = Environment.infoDictionary[Keys.Plist.rootURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLString) else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
    
    static let env: EnvType = {
        guard let envString = Environment.infoDictionary[Keys.Plist.envName] as? String else {
            fatalError("Environment type not set in plist for this environment")
        }
        guard let envType = EnvType.init(rawValue: envString) else {
            fatalError("Environment type is invalid")
        }
        return envType
    }()
    
    static let apiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("API key not set in plist for this environment")
        }
        return apiKeyString
    }()
    
    static let secret: String = {
        guard let secretString = Environment.infoDictionary[Keys.Plist.secret] as? String else {
            fatalError("Secret not set in plist for this environment")
        }
        return secretString
    }()
}
