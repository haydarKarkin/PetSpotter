//
//  DetailDataSource.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import UIKit

class DetailDataSource: NSObject {
    private var sections: [String: [CellType]] = [:]
    
    var titles: [String] {
        return sections.keys.sorted().reversed()
    }
    
    var indexes: [String] {
        return titles
            .map { String($0.first!) }
            .reduce(into: Set<String>(), { $0.insert($1) })
            .sorted()
            .reversed()
    }
    
    init(animal: Animal) {
        let imageItem = CellImageItem(photos: animal.photos)
        let imageCellType = CellType.image(imageItem)
        sections["Photos"] = [imageCellType]
        
        let orgItem = CellButtonItem(title: "Organization", action: .animalDetail(id: animal.organizationID ?? ""))
        let orgCellType = CellType.button(orgItem)
        let videoItem = CellButtonItem(title: "Videos", action: .video(videos: animal.videos))
        let videoCellType = CellType.button(videoItem)
        sections["Links"] = [orgCellType, videoCellType]
        
        let typeItem = CellTextItem.init(title: "Type", description: animal.type ?? "N/A")
        let typeCellType = CellType.text(typeItem)
        let breedItem = CellTextItem.init(title: "Breed", description: animal.breeds?.primary ?? "N/A")
        let breedCellType = CellType.text(breedItem)
        let ageItem = CellTextItem.init(title: "Age", description: animal.age ?? "N/A")
        let ageCellType = CellType.text(ageItem)
        let genderItem = CellTextItem.init(title: "Gender", description: animal.gender ?? "N/A")
        let genderCellType = CellType.text(genderItem)
        let descItem = CellTextItem.init(title: "Description", description: animal.animalDescription ?? "N/A")
        let descCellType = CellType.text(descItem)
        sections["General Info"] = [typeCellType, breedCellType, ageCellType, genderCellType, descCellType]
    }
    
    init(organization: Organization) {
        
    }
}

extension DetailDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let title = titles[section]
        return sections[title]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let title = titles[indexPath.section]
        guard let cellType = sections[title]?[indexPath.row] else {
            return tableView.dequeueEmptyCell(indexPath: indexPath)
        }
        
        switch cellType {
        case .button(let item):
            let cell: ButtonCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.configure(with: item)
            return cell
        case .image(let item):
            let cell: ImageCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.configure(with: item)
            return cell
        case .text(let item):
            let cell: TextCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.configure(with: item)
            return cell
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexes
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return titles.firstIndex(where: { $0.hasPrefix(title) }) ?? 0
    }
}
