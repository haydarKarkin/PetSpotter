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
    func getFavorite(animal: Animal, completion: @escaping(Result<Favorite?, Error>) -> ())
    func saveFavorite(animal: Animal, completion: @escaping(Bool) -> ())
    func deleteFavorite(animal: Animal, completion: @escaping(Bool) -> ())
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
    
    func getFavorite(animal: Animal, completion: @escaping(Result<Favorite?, Error>) -> ()) {
        let fetchRequest = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id LIKE %@", "\(animal.id)")
        
        let managedContext = dataController.persistentContainer.viewContext
        
        do {
            let favorite = try managedContext.fetch(fetchRequest).first
            completion(.success(favorite))
        } catch let error as NSError {
            print("Could not get. \(error), \(error.userInfo)")
            completion(.failure(error))
        }
    }
    
    func saveFavorite(animal: Animal, completion: @escaping(Bool) -> ()) {
        let managedContext = dataController.persistentContainer.viewContext
                
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let favorite = NSManagedObject(entity: entity, insertInto: managedContext) as? Favorite
        
        favorite?.id = "\(animal.id)"
        favorite?.name = animal.name
        
        do {
            try managedContext.save()
            completion(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    func deleteFavorite(animal: Animal, completion: @escaping(Bool) -> ()) {
        let managedContext = dataController.persistentContainer.viewContext
        
        getFavorite(animal: animal) { result in
            switch result {
            case .success(let favorite):
                if let favorite = favorite {
                    managedContext.delete(favorite)
                    do {
                        try managedContext.save()
                        completion(true)
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            case .failure:
                completion(false)
            }
        }
    }
}
