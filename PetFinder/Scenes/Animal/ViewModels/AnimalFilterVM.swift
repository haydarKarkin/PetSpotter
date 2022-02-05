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
    
    private let animalTypes: [AnimalType]
    
    init(animalTypes: [AnimalType]) {
        self.animalTypes = animalTypes
    }
}

// MARK: - VM I/O
extension AnimalFilterVM {
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        output(Output())
    }
}

// MARK: - Logics
extension AnimalFilterVM: AnimalFilterVMType {
}
