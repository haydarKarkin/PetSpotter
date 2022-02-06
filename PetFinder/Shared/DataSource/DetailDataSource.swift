//
//  DetailDataSource.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import UIKit

protocol DetailDataSourceDelegate: AnyObject {
    func animalDetailTapped(id: String)
    func organizationDetailTapped(id: String)
    func videosTapped(videos: [Video])
}

class DetailDataSource: NSObject {
    private var sections: [String: [CellType]] = [:]
    weak var delegate: DetailDataSourceDelegate?
    
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
    
    init(animal: Animal, delegate: DetailDataSourceDelegate) {
        self.delegate = delegate
        sections = animal.makeSections()
    }
    
    init(organization: Organization, delegate: DetailDataSourceDelegate) {
        self.delegate = delegate
        sections = organization.makeSections()
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
            cell.configure(with: item, delegate: self)
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

extension DetailDataSource: ButtonCellDelegate {
    func animalDetailTapped(id: String) {
        delegate?.animalDetailTapped(id: id)
    }
    
    func organizationDetailTapped(id: String) {
        delegate?.organizationDetailTapped(id: id)
    }
    
    func videosTapped(videos: [Video]) {
        delegate?.videosTapped(videos: videos)
    }
    
}
