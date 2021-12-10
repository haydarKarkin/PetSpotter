//
//  AnimalsVM.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

class AnimalsVM: ViewModelType {
    
    private var currentPage: Int = 1
    private var animals: [Animal] = [Animal]()
    private var totalCount: Int = 0
    
    private let animalService: AnimalServiceType
    
    init(animalService: AnimalServiceType) {
        self.animalService = animalService
    }
}

// MARK: - VM I/O
extension AnimalsVM {
    struct Input {
        var animals: (([Animal]) -> Void)?
    }
    
    struct Output {
        var next: (() -> Void)?
        var getAnimals: (() -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        let next: (() -> Void)? = {
            self.nextPage(completion: input.animals)
        }
        
        let getAnimals: (() -> Void)? = {
            self.getAnimals(completion: input.animals)
        }
        
        output(Output(next: next, getAnimals: getAnimals))
    }
}

// MARK: - Logics
extension AnimalsVM {
    
    func getAnimals(page: Int = 1, completion: (([Animal]) -> Void)?) {
        self.onLoadHandling?(true)
        
        currentPage = page
        
        animalService.getAnimals(page: page) { result in
            self.onLoadHandling?(false)
            switch result {
            case .success(let resp):
                self.animals = self.animals + (resp.animals ?? [])
                self.totalCount = resp.pagination?.totalCount ?? 0
                completion?(self.animals)
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        }
    }
    
    func nextPage(completion: (([Animal]) -> Void)?) {
        if animals.count < totalCount {
            let nextPage = currentPage + 1
            getAnimals(page: nextPage, completion: completion)
        }
    }
}
