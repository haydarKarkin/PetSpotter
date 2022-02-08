//
//  Dictionary+Ext.swift
//  PetSpotter
//
//  Created by hkarkin on 9.02.2022.
//

import Foundation

extension Dictionary where Value: Equatable {
    func key(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
