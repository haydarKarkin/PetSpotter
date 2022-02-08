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
        sections["1. Photos"] = [imageCellType]
        
        let orgItem = CellButtonItem(title: "Organization", action: .organizationDetail(id: self.organizationID ?? ""))
        let orgCellType = CellType.button(orgItem)
        sections["2. Links"] = [orgCellType]
                                
        if !self.videos.isEmpty {
            let videoItem = CellButtonItem(title: "Videos", action: .video(videos: self.videos))
            let videoCellType = CellType.button(videoItem)
            sections["2. Links"]?.append(videoCellType)
        }
        
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
        sections["3. General Info"] = [typeCellType, breedCellType, ageCellType, genderCellType, descCellType]
        
        let address1Item = CellTextItem.init(title: "Address 1", description: self.contact?.address?.address1 ?? "N/A")
        let address1CellType = CellType.text(address1Item)
        let cityItem = CellTextItem.init(title: "City", description: self.contact?.address?.city ?? "N/A")
        let cityCellType = CellType.text(cityItem)
        let stateItem = CellTextItem.init(title: "State", description: self.contact?.address?.state ?? "N/A")
        let stateCellType = CellType.text(stateItem)
        let postcodeItem = CellTextItem.init(title: "Post Code", description: self.contact?.address?.postcode ?? "N/A")
        let postcodeCellType = CellType.text(postcodeItem)
        let countryItem = CellTextItem.init(title: "Country", description: self.contact?.address?.country ?? "N/A")
        let countryCellType = CellType.text(countryItem)
        let phoneItem = CellTextItem.init(title: "Phone", description: self.contact?.phone ?? "N/A")
        let phoneCellType = CellType.text(phoneItem)
        let emailItem = CellTextItem.init(title: "Description", description: self.contact?.email ?? "N/A")
        let emailCellType = CellType.text(emailItem)
        sections["4. Contact"] = [address1CellType, cityCellType, stateCellType, postcodeCellType, countryCellType, phoneCellType, emailCellType]
        
        return sections
    }
}
