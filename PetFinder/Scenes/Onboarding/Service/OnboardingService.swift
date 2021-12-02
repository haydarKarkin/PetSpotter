//
//  OnboardingService.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation

protocol OnboardingServiceType {
    func getCredentials(completion: @escaping(Error?) -> ())
}

class OnboardingService: OnboardingServiceType {
    
    let provider: ClientProvider<OnboardingAPI>
    
    init(provider: ClientProvider<OnboardingAPI>) {
        self.provider = provider
    }
}

extension OnboardingService {
    
    func getCredentials(completion: @escaping(Error?) -> ()) {
        provider.request(target: .token,
                         responseType: Token.self) { result in
            
            switch result {
            case .success(let resp):
                do {
                    try UserDefaults.standard.setObject(resp, forKey: UserDefaults.Keys.token.rawValue)
                    completion(nil)
                } catch {
                    print(error.localizedDescription)
                    completion(ErrorHandler.ErrorType.decodingFailed)
                }
            case .failure(let error):
                completion(error)
                print(error.localizedDescription)
            }
        }
    }
}
