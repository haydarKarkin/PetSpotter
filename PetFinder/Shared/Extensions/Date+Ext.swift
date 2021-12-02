//
//  Date+Ext.swift
//  PetFinder
//
//  Created by hkarkin on 3.12.2021.
//

import Foundation

extension Date {
    func adding(seconds: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: seconds, to: self)!
    }
    
    static func -(recent: Date, previous: Date) -> Int {
        Calendar.current.dateComponents([.second], from: previous, to: recent).second ?? 0
    }
}
