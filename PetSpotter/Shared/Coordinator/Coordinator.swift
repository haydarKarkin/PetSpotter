//
//  Coordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

protocol Route { }

class Coordinator<RouteType: Route> {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, initialRoute: RouteType?) {
        self.navigationController = navigationController
        
        if let initialRoute = initialRoute {
            navigate(route: initialRoute)
        }
    }
    
    func navigate(route: RouteType) {
        fatalError("Please override the \(#function) method.")
    }
}
