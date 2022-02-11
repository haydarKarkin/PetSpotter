//
//  ClientProvider.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

enum StubType {
    case never
    case immediatelyStub
}

final class ClientProvider<T: TargetType> {
    private let urlSession: URLSession
    private let cache = NSCache<NSString, NSData>()
    private let shouldStub: StubType
    
    init(shouldStub: StubType = .never) {
        self.shouldStub = shouldStub
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        self.urlSession = URLSession(configuration: sessionConfig)
    }
    
    func request<U>(target: T, responseType: U.Type, completion: @escaping (Result<U, Error>) -> Void) where U: Decodable {
        load(target) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Configs.Network.dateFormatter)
                
                do {
                    let resp = try decoder.decode(responseType, from: data)
                    completion(.success(resp))
                }
                catch(let error) {
                    print(error)
                    completion(.failure(ErrorHandler.ErrorType.decodingFailed))
                }
            case .failure(let error):
                let convertedError = ErrorHandler.ErrorType.convertError(error)
                completion(.failure(convertedError))
            }
        }
    }
}

extension ClientProvider {
    private func load(_ target: T, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (Result<Data, Error>) -> Void) {
        
        if shouldStub == .immediatelyStub {
            completion(.success(target.sampleData))
            return
        }
        
        guard let url = target.urlRequest.url?.absoluteString else {
            completion(.failure(ErrorHandler.ErrorType.missingURL))
            return
        }
        
        if target.cacheable {
            getCacheData(from: url) { data in
                completion(.success(data))
                return
            }
        }
        
        urlSession.dataTask(with: target.urlRequest) { (data, _, error) in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            }
        }.resume()
    }
    
    private func setCacheData(with key: String, data: Data) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    private func getCacheData(from key: String, completion: @escaping (Data) -> Void) {
        let cacheID = NSString(string: key)
        
        if let cachedData = cache.object(forKey: cacheID) {
            completion(cachedData as Data)
        }
    }
}
