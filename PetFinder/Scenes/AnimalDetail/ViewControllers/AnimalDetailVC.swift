//
//  AnimalDetailVC.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import UIKit

class AnimalDetailVC: ViewController<AnimalDetailVM> {
    
    //MARK: - Outlets
    
    // MARK: - Properties
    var animals: [Animal] = [Animal]()
    
    // MARK: - VM Binders
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = AnimalDetailVM.Input()
        
        viewModel.transform(input: input){ [weak self] (output) in
            self?.title = output.animal.name
        }
    }
}

// MARK: - Storyboarded
extension AnimalDetailVC: Storyboarded {
    static var storyboardName = StoryboardName.animalDetail
}
