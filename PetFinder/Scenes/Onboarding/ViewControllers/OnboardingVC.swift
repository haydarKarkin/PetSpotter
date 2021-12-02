//
//  OnboardingVC.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import UIKit

class OnboardingVC: ViewController<OnboardingVM> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = OnboardingVM.Input()
        viewModel.transform(input: input) { _ in }
    }
}

// MARK: - Storyboarded
extension OnboardingVC: Storyboarded {
    static var storyboardName = StoryboardName.onboarding
}
