//
//  AnimalFilterVM.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import Foundation

protocol AnimalFilterVMType {
}

class AnimalFilterVM: ViewModelType {
    
    private let filter: Filter
    
    init(filter: Filter) {
        self.filter = filter
    }
}

// MARK: - VM I/O
extension AnimalFilterVM {
    struct Input {
    }
    
    struct Output {
        var filter: Filter
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        output(Output(filter: filter))
    }
}

// MARK: - Logics
extension AnimalFilterVM: AnimalFilterVMType {
}
