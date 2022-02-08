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
        sections["1. Photos"] = [imageCellType]
        
        let animalsItem = CellButtonItem(title: "Animals", action: .animals(organizationID: self.id))
        let animalsCellType = CellType.button(animalsItem)
        sections["2. Links"] = [animalsCellType]
        
        let address1Item = CellTextItem.init(title: "Address 1", description: self.address?.address1 ?? "N/A")
        let address1CellType = CellType.text(address1Item)
        let cityItem = CellTextItem.init(title: "City", description: self.address?.city ?? "N/A")
        let cityCellType = CellType.text(cityItem)
        let stateItem = CellTextItem.init(title: "State", description: self.address?.state ?? "N/A")
        let stateCellType = CellType.text(stateItem)
        let postcodeItem = CellTextItem.init(title: "Post Code", description: self.address?.postcode ?? "N/A")
        let postcodeCellType = CellType.text(postcodeItem)
        let countryItem = CellTextItem.init(title: "Country", description: self.address?.country ?? "N/A")
        let countryCellType = CellType.text(countryItem)
        let phoneItem = CellTextItem.init(title: "Phone", description: self.phone ?? "N/A")
        let phoneCellType = CellType.text(phoneItem)
        let emailItem = CellTextItem.init(title: "Description", description: self.email ?? "N/A")
        let emailCellType = CellType.text(emailItem)
        sections["3. Contact"] = [address1CellType, cityCellType, stateCellType, postcodeCellType, countryCellType, phoneCellType, emailCellType]
        
        let mondayItem = CellTextItem.init(title: "Monday", description: self.hours?.monday ?? "N/A")
        let mondayCellType = CellType.text(mondayItem)
        let tuesdayItem = CellTextItem.init(title: "Tuesday", description: self.hours?.monday ?? "N/A")
        let tuesdayCellType = CellType.text(tuesdayItem)
        let wednesdayItem = CellTextItem.init(title: "Wednesday", description: self.hours?.monday ?? "N/A")
        let wednesdayCellType = CellType.text(wednesdayItem)
        let thursdayItem = CellTextItem.init(title: "Thursday", description: self.hours?.monday ?? "N/A")
        let thursdayCellType = CellType.text(thursdayItem)
        let fridayItem = CellTextItem.init(title: "Friday", description: self.hours?.monday ?? "N/A")
        let fridayCellType = CellType.text(fridayItem)
        let saturdayItem = CellTextItem.init(title: "Saturday", description: self.hours?.monday ?? "N/A")
        let saturdayCellType = CellType.text(saturdayItem)
        let sundayItem = CellTextItem.init(title: "Sunday", description: self.hours?.monday ?? "N/A")
        let sundayCellType = CellType.text(sundayItem)
        sections["4. Work Hours"] = [mondayCellType, tuesdayCellType, wednesdayCellType, thursdayCellType, fridayCellType, saturdayCellType, sundayCellType]
        
        return sections
    }
}
