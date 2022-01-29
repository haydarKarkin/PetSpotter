//
//  FavoriteService.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation

protocol FavoriteServiceType {
    func getFavorites(completion: @escaping([Favorite]) -> ())
}

class FavoriteService: FavoriteServiceType {
}

extension FavoriteService {
    
    func getFavorites(completion: @escaping([Favorite]) -> ()) {
        
    }
}
