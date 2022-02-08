//
//  Pagination.swift
//  PetFinder
//
//  Created by hkarkin on 10.12.2021.
//

import Foundation

// MARK: - Pagination
struct Pagination: Codable {
    let countPerPage: Int
    let totalCount: Int
    let currentPage: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case countPerPage = "count_per_page"
        case totalCount = "total_count"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}
