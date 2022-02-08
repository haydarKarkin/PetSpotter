//
//  CellType.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import Foundation

enum CellType {
    case image(CellImageItem)
    case text(CellTextItem)
    case button(CellButtonItem)
}

struct HeaderTitleItem: Hashable {
    let order: Int
    let title: String
}

struct CellImageItem {
    let photos: [Photo]
}

struct CellTextItem {
    let title: String
    let description: String
}

struct CellButtonItem {
    let title: String
    let action: CellItemAction
    
    enum CellItemAction {
        case animals(organizationID: String)
        case organizationDetail(id: String)
        case video(videos: [Video])
    }
}
