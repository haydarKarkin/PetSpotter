//
//  AnimalsVM.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

class AnimalsVM: ViewModelType {
    
    private let animalService: AnimalServiceType!
    
    init(animalService: AnimalServiceType) {
        self.animalService = animalService
    }
}

// MARK: - VM I/O
extension AnimalsVM {
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        output(Output())
    }
}
