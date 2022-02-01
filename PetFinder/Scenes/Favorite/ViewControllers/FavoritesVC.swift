//
//  FavoritesVC.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import UIKit

class FavoritesVC: ViewController<FavoritesVM> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        title = "Favorites"
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = FavoritesVM.Input()
        viewModel.transform(input: input) { _ in }
    }
}

// MARK: - Storyboarded
extension FavoritesVC: Storyboarded {
    static var storyboardName = StoryboardName.favorite
}
