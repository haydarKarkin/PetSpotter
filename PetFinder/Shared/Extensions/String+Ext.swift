//
//  String+Ext.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

extension String {
    
    static func className(_ obj: AnyObject) -> String {
        return String(describing: obj.self).components(separatedBy: ".").last!
    }
    
    static func className(_ cls: AnyClass) -> String {
        return String(describing: cls).components(separatedBy: ".").last!
    }
}
