//
//  AnimalFilterVC.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import UIKit

class AnimalFilterVC: ViewController<AnimalFilterVM> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        title = "Favorites"
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = AnimalFilterVM.Input()
        viewModel.transform(input: input) { _ in }
    }
}

// MARK: - Storyboarded
extension AnimalFilterVC: Storyboarded {
    static var storyboardName = StoryboardName.animal
}
