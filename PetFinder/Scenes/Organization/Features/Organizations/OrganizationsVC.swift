//
//  OrganizationsVC.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import UIKit

class OrganizationsVC: ViewController<OrganizationsVM> {
    
    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var organizations: [Organization] = [Organization]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - VM Binders
    var nextClosure: (() -> Void)?
    var getOrganizationsClosure: (() -> Void)?
    var openDetailClosure: ((Organization) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        
        title = "Organizations"
        
        // setup tableviewe
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = Configs.UI.estimatedRowHeight
        tableView.registerCellNib(OrganizationCell.self)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let organizationsClosure: (([Organization]) -> Void)? = { [weak self] (result) in
            DispatchQueue.main.async {
                self?.organizations = result
            }
        }
        
        let input = OrganizationsVM.Input(organizations: organizationsClosure)
        
        viewModel.transform(input: input){ (output) in
            self.nextClosure = output.next
            self.getOrganizationsClosure = output.getOrganizations
            self.openDetailClosure = output.openDetail
        }
        getOrganizationsClosure?()
    }
}

// MARK: - Storyboarded
extension OrganizationsVC: Storyboarded {
    static var storyboardName = StoryboardName.organization
}

// MARK: - UITableViewDataSource
extension OrganizationsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrganizationCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(with: organizations[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension OrganizationsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        openDetailClosure?(organizations[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let isReachedBottom = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        if isReachedBottom {
            nextClosure?()
        }
    }
}
