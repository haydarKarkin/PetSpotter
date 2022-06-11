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
    private let animalDetailCoordinator: any Coordinator<AnimalDetailRoute>
    private let organizationService: OrganizationServiceType
   
    init(animal: Animal,
         favoriteService: FavoriteServiceType,
         organizationService: OrganizationServiceType,
         animalDetailCoordinator: any Coordinator<AnimalDetailRoute>) {
        self.animal = animal
        self.favoriteService = favoriteService
        self.organizationService = organizationService
        self.animalDetailCoordinator = animalDetailCoordinator
    }
}

// MARK: - VM I/O
extension AnimalDetailVM {
    struct Input {
        var isFavorited: ((Bool) -> Void)?
    }
    
    struct Output {
        var animal: Animal
        var getFavorite: (() -> Void)?
        var saveFavorite: (() -> Void)?
        var deleteFavorite: (() -> Void)?
        var openOrgDetail: ((String) -> Void)?
        var openVideos: (([Video]) -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        let getFavorite: (() -> Void)? = {
            self.getFavorite(completion: input.isFavorited)
        }
        let saveFavorite: (() -> Void)? = {
            self.saveFavorite(completion: input.isFavorited)
        }
        let deleteFavorite: (() -> Void)? = {
            self.deleteFavorite(completion: input.isFavorited)
        }
        let openOrgDetail: ((String) -> Void)? = { id in
            self.showOrgDetail(with: id)
        }
        let openVideos: (([Video]) -> Void)? = { videos in
            self.showVideos(with: videos)
        }
        output(Output(animal: animal,
                      getFavorite: getFavorite,
                      saveFavorite: saveFavorite,
                      deleteFavorite: deleteFavorite,
                      openOrgDetail: openOrgDetail,
                      openVideos: openVideos))
    }
}

// MARK: - Logics
extension AnimalDetailVM {
    
    func getFavorite(completion: ((Bool) -> Void)?) {
        favoriteService.getFavorite(animal: animal) { result in
            switch result {
            case .success(let favorite):
                if favorite != nil {
                    completion?(true)
                } else {
                    completion?(false)
                }
            case .failure:
                completion?(false)
            }
        }
    }
    
    func saveFavorite(completion: ((Bool) -> Void)?) {
        favoriteService.saveFavorite(animal: animal) { result in
            completion?(result)
        }
    }
    
    func deleteFavorite(completion: ((Bool) -> Void)?) {
        favoriteService.deleteFavorite(animal: animal) { result in
            completion?(!result)
        }
    }
    
    func showOrgDetail(with id: String) {
        self.onLoadHandling?(true)
        organizationService.getOrganization(id: id) { [weak self] result in
            guard let self = self else { return }
            self.onLoadHandling?(false)
            switch result {
            case .success(let resp):
                self.animalDetailCoordinator.navigate(to: .organizationDetail(resp.organization))
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        }
    }
    
    func showVideos(with videos: [Video]) {
        self.animalDetailCoordinator.navigate(to: .videos(videos))
    }
}
