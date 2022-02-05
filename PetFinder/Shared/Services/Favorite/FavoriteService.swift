//
//  FavoriteService.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation
import CoreData

protocol FavoriteServiceType {
    func getFavorites(completion: @escaping(Result<[Favorite], Error>) -> ())
    func saveFavorite(favorite: Favorite, completion: @escaping(Bool) -> ())
    func deleteFavorite(favorite: Favorite, completion: @escaping(Bool) -> ())
}

class FavoriteService: FavoriteServiceType {
    lazy var dataController = DataController.sharedManager
}

extension FavoriteService {
    
    func getFavorites(completion: @escaping(Result<[Favorite], Error>) -> ()) {
        let managedContext = dataController.persistentContainer.viewContext

        do {
            let favorites = try managedContext.fetch(Favorite.fetchRequest())
            completion(.success(favorites))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return completion(.failure(error))
        }
    }
    
    func saveFavorite(favorite: Favorite, completion: @escaping(Bool) -> ()) {
        
    }
    
    func deleteFavorite(favorite: Favorite, completion: @escaping(Bool) -> ()) {
        
    }
}
