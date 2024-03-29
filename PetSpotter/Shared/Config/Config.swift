//
//  Config.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation
import UIKit

struct Configs {
    struct Text {
        static let globalErrorTitle = "There is a problem!"
        static let globalErrorDesc = "Please try again later."
        static let userNoFavorite = "You don't have any favorite animal.\n Please add animals."
        static let noSearchResult = "No results were found.\n Please try a different search."
        static let globalNoResult = "\(globalErrorTitle) \n \(globalErrorDesc)"
    }
    
    struct Network {
        static let paginationNumber: Int = 20
        static let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            return dateFormatter
        }()
        static let minCharForSearch: Int = 3
    }
    
    struct UI {
        static let estimatedRowHeight: CGFloat = 60.0
    }
}
