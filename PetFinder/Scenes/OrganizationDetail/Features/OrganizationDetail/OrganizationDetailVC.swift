//
//  OrganizationDetailVC.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import UIKit

class OrganizationDetailVC: ViewController<OrganizationDetailVM> {
    
    //MARK: - Outlets
    
    // MARK: - Properties
    
    // MARK: - VM Binders
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = OrganizationDetailVM.Input()
        
        viewModel.transform(input: input){ [weak self] (output) in
            self?.title = output.organization.name
        }
    }
}

// MARK: - Storyboarded
extension OrganizationDetailVC: Storyboarded {
    static var storyboardName = StoryboardName.organizationDetail
}
