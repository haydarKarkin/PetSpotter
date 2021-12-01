//
//  OrganizationsVC.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import UIKit

class OrganizationsVC: ViewController<OrganizationsVM> {
    
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
extension OrganizationsVC: Storyboarded {
    static var storyboardName = StoryboardName.organization
}
