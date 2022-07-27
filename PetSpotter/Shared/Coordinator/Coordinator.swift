//
//  Coordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

protocol Route { }

protocol Coordinator<RouteType> {
    associatedtype RouteType: Route
    func start()
    func navigate(to route: RouteType)
}
