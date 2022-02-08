//
//  Favorite+CoreDataProperties.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: Data?
    @NSManaged public var imageUrl: URL?
    @NSManaged public var name: String?

}

extension Favorite : Identifiable {

}
