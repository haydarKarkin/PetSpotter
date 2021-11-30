//
//  ViewModel.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

typealias ViewModelType = ViewModel & ViewModelTransformType

protocol ViewModelTransformType: AnyObject {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input, output: @escaping(Output) -> ())
}

class ViewModel: NSObject {
    
    var onErrorHandling : ((Error?) -> Void)?
    var onLoadHandling : ((Bool) -> Void)?
    
    override init() {
        super.init()
    }
}
