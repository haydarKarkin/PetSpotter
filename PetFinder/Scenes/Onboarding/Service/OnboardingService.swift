//
//  OnboardingService.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation

protocol OnboardingServiceType {
    func getCredentials(completion: @escaping(Result<Token, Error>) -> ())
}

class OnboardingService: OnboardingServiceType {
    
    let provider: ClientProvider<OnboardingAPI>
    
    init(provider: ClientProvider<OnboardingAPI>) {
        self.provider = provider
    }
}

extension OnboardingService {
    
    func getCredentials(completion: @escaping(Result<Token, Error>) -> ()) {
        provider.request(target: .token,
                         responseType: Token.self) { result in
            
            switch result {
            case .success(let resp):
                completion(.success(resp))
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
}
