//
//  AnimalMapVM.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation
import CoreLocation

class AnimalMapVM: ViewModelType {
    
    private let animalService: AnimalServiceType
    private let animalMapCoordinator: any Coordinator<AnimalMapRoute>
    
    init(animalService: AnimalServiceType,
         animalMapCoordinator: any Coordinator<AnimalMapRoute>) {
        self.animalService = animalService
        self.animalMapCoordinator = animalMapCoordinator
    }
}

// MARK: - VM I/O
extension AnimalMapVM {
    struct Input {
        var animals: (([Animal]) -> Void)?
    }
    
    struct Output {
        var getAnimalsByLocation: ((CLLocationCoordinate2D) -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        let getAnimalsByLocation: ((CLLocationCoordinate2D) -> Void)? = { location in
            self.getAnimals(by: location, completion: input.animals)
        }
        
        output(Output(getAnimalsByLocation: getAnimalsByLocation))
    }
}

// MARK: - Logics
extension AnimalMapVM {
    
    func getAnimals(by location: CLLocationCoordinate2D, completion: (([Animal]) -> Void)?) {
        self.onLoadHandling?(true)
        
        let loc = "\(location.latitude),\(location.longitude)"
        
        animalService.getAnimalsByLocation(location: loc) { result in
            self.onLoadHandling?(false)
            switch result {
            case .success(let resp):
                completion?(resp.animals ?? [])
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        }
    }
}
