//
//  Animal+DataSource.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import Foundation

extension Animal {
    
    func makeSections() -> [String: [CellType]] {
        var sections: [String: [CellType]] = [:]
        
        let imageItem = CellImageItem(photos: self.photos)
        let imageCellType = CellType.image(imageItem)
        sections["Photos"] = [imageCellType]
        
        let orgItem = CellButtonItem(title: "Organization", action: .organizationDetail(id: self.organizationID ?? ""))
        let orgCellType = CellType.button(orgItem)
        let videoItem = CellButtonItem(title: "Videos", action: .video(videos: self.videos))
        let videoCellType = CellType.button(videoItem)
        sections["Links"] = [orgCellType, videoCellType]
        
        let typeItem = CellTextItem.init(title: "Type", description: self.type ?? "N/A")
        let typeCellType = CellType.text(typeItem)
        let breedItem = CellTextItem.init(title: "Breed", description: self.breeds?.primary ?? "N/A")
        let breedCellType = CellType.text(breedItem)
        let ageItem = CellTextItem.init(title: "Age", description: self.age ?? "N/A")
        let ageCellType = CellType.text(ageItem)
        let genderItem = CellTextItem.init(title: "Gender", description: self.gender ?? "N/A")
        let genderCellType = CellType.text(genderItem)
        let descItem = CellTextItem.init(title: "Description", description: self.animalDescription ?? "N/A")
        let descCellType = CellType.text(descItem)
        sections["General Info"] = [typeCellType, breedCellType, ageCellType, genderCellType, descCellType]
        
        return sections
    }
}
