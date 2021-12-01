//
//  Coordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
