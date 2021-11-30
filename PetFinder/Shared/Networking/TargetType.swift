//
//  TargetType.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

enum TargetMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: TargetMethod { get }
    var cacheable: Bool { get }
    var sampleData: Data { get }
}

extension TargetType {
    /// url request for network calls
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    /// create url with parameters
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        
        if method == .get {
            guard let parameters = parameters else {
                return urlComponents?.url
            }
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: String(describing:$0.value)) }
        }
        
        return urlComponents?.url
    }
    
    /// return false in default
    var cacheable: Bool {
        return false
    }
    
    /// return stubbed data from json file
    func stubbedResponse(_ fileName: String) -> Data {
        if let bundle = Bundle.main.url(forResource: fileName, withExtension: "json") {
            return (try? Data(contentsOf: bundle)) ?? Data()
        }
        return Data()
    }
}
