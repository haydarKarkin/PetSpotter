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
    private var filter: Filter = Filter()
    
    private let animalService: AnimalServiceType
    private let animalCoordinator: any Coordinator<AnimalRoute>
    private let organizationID: String?
    
    init(animalService: AnimalServiceType,
         animalCoordinator: any Coordinator<AnimalRoute>,
         organizationID: String?) {
        self.animalService = animalService
        self.animalCoordinator = animalCoordinator
        self.organizationID = organizationID
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
        var openDetail: ((Animal) -> Void)?
        var openFilter: ((AnimalsVC) -> Void)?
        var searchAnimals: ((Filter) -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        let next: (() -> Void)? = {
            self.nextPage(completion: input.animals)
        }
        
        let getAnimals: (() -> Void)? = {
            self.getAnimals(completion: input.animals)
        }
        
        let openDetail: ((Animal) -> Void)? = { animal in
            self.showAnimalDetail(with: animal)
        }
        
        let openFilter: ((AnimalsVC) -> Void)? = { delegate in
            self.openFilter(delegate: delegate)
        }
        
        let searchAnimals: ((Filter) -> Void)? = { filter in
            self.searchAnimals(filter: filter, completion: input.animals)
        }
        
        output(Output(next: next,
                      getAnimals: getAnimals,
                      openDetail: openDetail,
                      openFilter: openFilter,
                      searchAnimals: searchAnimals))
    }
}

// MARK: - Logics
extension AnimalsVM {
    
    func getAnimals(page: Int = 1,
                    completion: (([Animal]) -> Void)?) {
        self.onLoadHandling?(true)
        
        currentPage = page
        
        animalService.getAnimals(page: page,
                                 organizationID: organizationID,
                                 filter: filter) { [weak self] result in
            guard let self = self else { return }
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
    
    func showAnimalDetail(with animal: Animal) {
        animalCoordinator.navigate(to: .animalDetail(animal))
    }
    
    func openFilter(delegate: AnimalsVC) {
        animalCoordinator.navigate(to: .animalFilter(filter, delegate))
    }
    
    func searchAnimals(filter: Filter, completion: (([Animal]) -> Void)?) {
        self.filter = filter
        self.animals = []
        getAnimals(page: 1, completion: completion)
    }
}
