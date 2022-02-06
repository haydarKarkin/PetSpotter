//
//  Organization+DataSource.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import Foundation

extension Organization {
    
    func makeSections() -> [String: [CellType]] {
        var sections: [String: [CellType]] = [:]
        
        let imageItem = CellImageItem(photos: self.photos)
        let imageCellType = CellType.image(imageItem)
        sections["Photos"] = [imageCellType]
        
        return sections
    }
}
