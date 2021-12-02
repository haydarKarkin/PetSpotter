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
    var version: String { get }
    var shouldAuth: Bool { get }
}

extension TargetType {
    /// url request for network calls
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        switch method {
        case .post, .put:
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters as Any)
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                request.httpBody = data
            } catch {
                print("\(#function): \(error.localizedDescription)")
            }
        default:
            return request
        }
        
        if shouldAuth {
            do {
                let token = try UserDefaults.standard.getObject(forKey: UserDefaults.Keys.token.rawValue,
                                                                castTo: Token.self)
                request.allHTTPHeaderFields = token.authHeader
            } catch {
                print("\(#function): \(error.localizedDescription)")
            }
        }
        
        return request
    }
    
    /// create url with parameters
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = version + path
        
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
