//
//  OrganizationDetailVC.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import UIKit

class OrganizationDetailVC: ViewController<OrganizationDetailVM> {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var tableAdapter: TableAdapter!
    
    // MARK: - VM Binders
    var openAnimalsClosure: ((String) -> Void)?
    
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
            guard let self = self else { return }
            self.title = output.organization.name
            self.openAnimalsClosure = output.openAnimals
            
            self.tableAdapter = TableAdapter(tableView: self.tableView, delegate: self, organization: output.organization)
            self.tableAdapter.reload()
        }
    }
}

// MARK: - Storyboarded
extension OrganizationDetailVC: Storyboarded {
    static var storyboardName = StoryboardName.organizationDetail
}

// MARK: - OrganizationDetailVCTableAdapterDelegate
extension OrganizationDetailVC: OrganizationDetailVCTableAdapterDelegate {
    func animalsTapped(id: String) {
        openAnimalsClosure?(id)
    }
    
    func organizationDetailTapped(id: String) {
    }
    
    func videosTapped(videos: [Video]) {
    }
}
