//
//  AnimalFilterVC.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import UIKit

class AnimalFilterVC: ViewController<AnimalFilterVM> {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ageListView: TagListView!
    @IBOutlet weak var sizeListView: TagListView!
    @IBOutlet weak var genderListView: TagListView!
    @IBOutlet weak var coatListView: TagListView!
    @IBOutlet weak var statusListView: TagListView!
    @IBOutlet weak var otherListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        title = "Favorites"
        
        searchTextField.layer.cornerRadius = 15.0
        searchTextField.layer.borderWidth = 2.0
        searchTextField.layer.borderColor = UIColor(named: "PrimaryBlack")?.cgColor
        searchTextField.setLeftPaddingPoints(16)
        searchTextField.setRightPaddingPoints(16)
        
        [ageListView, sizeListView, genderListView, coatListView, statusListView, otherListView].forEach { view in
            view!.tag = 0
            view!.delegate = self
            view!.textFont = .systemFont(ofSize: 15)
            view!.minWidth = 57
            view!.alignment = .left
            view!.tagBackgroundColor = UIColor(named: "PrimaryBlack")!
            view!.tagSelectedBackgroundColor = UIColor(named: "PrimaryRed")
            view!.cornerRadius = 12
            view!.paddingY = 6
            view!.paddingX = 12
            view!.marginY = 5
            view!.marginX = 10
        }
        
        ageListView.addTags(["Baby", "Young", "Adult", "Senior"])
        sizeListView.addTags(["Small", "Medium", "Large", "Xlarge"])
        genderListView.addTags(["Male", "Female", "Unknown"])
        coatListView.addTags(["Short", "Medium", "Long", "Wire", "Hairless", "Curly"])
        statusListView.addTags(["Adoptable", "Adopted"])
        otherListView.addTags(["Good with Children", "Good with Dogs", "Good with Cats", "House Trained", "Declawed", "Special Needs"])
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

// MARK: - TagListViewDelegate
extension AnimalFilterVC: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagView.isSelected = !tagView.isSelected
        
        if sender == ageListView {
            
        } else if sender == sizeListView {
            
        } else if sender == genderListView {
            
        } else if sender == coatListView {
            
        } else if sender == statusListView {
            
        } else if sender == otherListView {
            
        }
    }
}

// MARK: - Tag Handling
extension AnimalFilterVC {
    
    func handleAgeTapping(_ title: String) {
        
    }
    func handleSizeTapping(_ title: String) {
        
    }
    func handleGenderTapping(_ title: String) {
        
    }
    func handleCoatTapping(_ title: String) {
        
    }
    func handleStatusTapping(_ title: String) {
        
    }
    func handleOtherTapping(_ title: String) {
        
    }
}
