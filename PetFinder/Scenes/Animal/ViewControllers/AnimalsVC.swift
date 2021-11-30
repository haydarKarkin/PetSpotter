//
//  AnimalsVC.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

class AnimalsVC: ViewController<AnimalsVM> {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
}

// MARK: - Storyboarded
extension AnimalsVC: Storyboarded {
    static var storyboardName = StoryboardName.animal
}
