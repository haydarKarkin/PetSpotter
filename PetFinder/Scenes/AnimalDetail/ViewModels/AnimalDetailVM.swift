//
//  AnimalDetailVM.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import Foundation

class AnimalDetailVM: ViewModelType {
    
    private let animal: Animal
    private let favoriteService: FavoriteServiceType
   
    init(animal: Animal,
         favoriteService: FavoriteServiceType) {
        self.animal = animal
        self.favoriteService = favoriteService
    }
}

// MARK: - VM I/O
extension AnimalDetailVM {
    struct Input {}
    
    struct Output {
        var animal: Animal
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        output(Output(animal: animal))
    }
}
