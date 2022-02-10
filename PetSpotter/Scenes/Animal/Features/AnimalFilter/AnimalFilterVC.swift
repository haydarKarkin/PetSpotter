//
//  AnimalFilterVC.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import UIKit

protocol AnimalFilterDelegate: AnyObject {
    func searchTapped(with filter: Filter)
}

class AnimalFilterVC: ViewController<AnimalFilterVM> {
    
    // MARK: - UI Elements
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ageListView: TagListView!
    @IBOutlet weak var sizeListView: TagListView!
    @IBOutlet weak var genderListView: TagListView!
    @IBOutlet weak var coatListView: TagListView!
    @IBOutlet weak var statusListView: TagListView!
    @IBOutlet weak var otherListView: TagListView!
    
    // MARK: - Properties
    weak var delegate: AnimalFilterDelegate?
    var selectedAges: [String] = []
    var selectedSizes: [String] = []
    var selectedGenders: [String] = []
    var selectedCoats: [String] = []
    var selectedStatuses: [String] = []
    var selectedOthers: [String: Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        title = "Favorites"
        
        searchButton.layer.cornerRadius = 15
        
        searchTextField.layer.cornerRadius = 15.0
        searchTextField.layer.borderWidth = 1.5
        searchTextField.layer.borderColor = UIColor(named: "PrimaryBlack")?.cgColor
        searchTextField.setLeftPaddingPoints(16)
        searchTextField.setRightPaddingPoints(16)
        searchTextField.placeholder = "Search Animals by Names"
        
        [ageListView, sizeListView, genderListView, coatListView, statusListView, otherListView].forEach { view in
            view!.tag = 0
            view!.delegate = self
            view!.textFont = .systemFont(ofSize: 15)
            view!.textColor = UIColor(named: "PrimaryWhite")!
            view!.selectedTextColor = UIColor(named: "PrimaryWhite")!
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
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = AnimalFilterVM.Input()
        viewModel.transform(input: input) { [weak self] (output) in
            guard let self = self else { return }
            self.searchTextField.text = output.filter.name
            self.selectedAges = output.filter.ages
            self.selectedGenders = output.filter.genders
            self.selectedSizes = output.filter.sizes
            self.selectedCoats = output.filter.coats
            self.selectedStatuses = output.filter.statuses
            self.selectedOthers = output.filter.others
            DispatchQueue.main.async { [weak self] in
                self?.assignTags()
            }
        }
    }
    
    @IBAction func searchDidTap(_ sender: Any) {
        var filter = Filter()
        filter.name = searchTextField.text
        filter.ages = selectedAges
        filter.sizes = selectedSizes
        filter.genders = selectedGenders
        filter.coats = selectedCoats
        filter.statuses = selectedStatuses
        filter.others = selectedOthers
        
        dismiss(animated: true) { [weak self] in
            self?.delegate?.searchTapped(with: filter)
        }
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
            handleAgeTapping(title, isSelected: tagView.isSelected)
        } else if sender == sizeListView {
            handleSizeTapping(title, isSelected: tagView.isSelected)
        } else if sender == genderListView {
            handleGenderTapping(title, isSelected: tagView.isSelected)
        } else if sender == coatListView {
            handleCoatTapping(title, isSelected: tagView.isSelected)
        } else if sender == statusListView {
            handleStatusTapping(title, isSelected: tagView.isSelected)
        } else if sender == otherListView {
            handleOtherTapping(title, isSelected: tagView.isSelected)
        }
    }
}

// MARK: - Tag Handling
extension AnimalFilterVC {
    
    func handleAgeTapping(_ title: String, isSelected: Bool) {
        if let key = Constant.ages.key(forValue: title) {
            if isSelected {
                selectedAges.append(key)
            } else {
                if let index = selectedAges.firstIndex(of: key) {
                    selectedAges.remove(at: index)
                }
            }
        }
    }
    func handleSizeTapping(_ title: String, isSelected: Bool) {
        if let key = Constant.sizes.key(forValue: title) {
            if isSelected {
                selectedSizes.append(key)
            } else {
                if let index = selectedSizes.firstIndex(of: key) {
                    selectedSizes.remove(at: index)
                }
            }
        }
    }
    func handleGenderTapping(_ title: String, isSelected: Bool) {
        if let key = Constant.genders.key(forValue: title) {
            if isSelected {
                selectedGenders.append(key)
            } else {
                if let index = selectedGenders.firstIndex(of: key) {
                    selectedGenders.remove(at: index)
                }
            }
        }
    }
    func handleCoatTapping(_ title: String, isSelected: Bool) {
        if let key = Constant.coats.key(forValue: title) {
            if isSelected {
                selectedCoats.append(key)
            } else {
                if let index = selectedCoats.firstIndex(of: key) {
                    selectedCoats.remove(at: index)
                }
            }
        }
    }
    func handleStatusTapping(_ title: String, isSelected: Bool) {
        if let key = Constant.statuses.key(forValue: title) {
            if isSelected {
                selectedStatuses.append(key)
            } else {
                if let index = selectedStatuses.firstIndex(of: key) {
                    selectedStatuses.remove(at: index)
                }
            }
        }
    }
    func handleOtherTapping(_ title: String, isSelected: Bool) {
        if let key = Constant.others.key(forValue: title) {
            selectedOthers[key] = isSelected
        }
    }
}

// MARK: - Assign Tags
extension AnimalFilterVC {
    func assignTags() {
        Constant.ages.forEach { age in
            if selectedAges.firstIndex(of: age.key) != nil {
                ageListView.addTag(age.value, isSelected: true)
            } else {
                ageListView.addTag(age.value)
            }
        }
        Constant.genders.forEach { age in
            if selectedGenders.firstIndex(of: age.key) != nil {
                genderListView.addTag(age.value, isSelected: true)
            } else {
                genderListView.addTag(age.value)
            }
        }
        Constant.sizes.forEach { age in
            if selectedSizes.firstIndex(of: age.key) != nil {
                sizeListView.addTag(age.value, isSelected: true)
            } else {
                sizeListView.addTag(age.value)
            }
        }
        Constant.coats.forEach { age in
            if selectedCoats.firstIndex(of: age.key) != nil {
                coatListView.addTag(age.value, isSelected: true)
            } else {
                coatListView.addTag(age.value)
            }
        }
        Constant.statuses.forEach { age in
            if selectedStatuses.firstIndex(of: age.key) != nil {
                statusListView.addTag(age.value, isSelected: true)
            } else {
                statusListView.addTag(age.value)
            }
        }
        Constant.others.forEach { age in
            if let value = selectedOthers[age.key] {
                otherListView.addTag(age.value, isSelected: value)
            } else {
                otherListView.addTag(age.value)
            }
        }
    }
}

// MARK: - Constants
extension AnimalFilterVC {
    enum Constant {
        static let ages: [String: String] = ["baby": "Baby", "young": "Young", "adult": "Adult", "senior": "Senior"]
        static let sizes: [String: String] = ["small": "Small", "medium": "Medium", "large": "Large", "xlarge": "Xlarge"]
        static let genders: [String: String] = ["male": "Male", "female": "Female", "unknown": "Unknown"]
        static let coats: [String: String] = ["short": "Short", "medium": "Medium", "wire": "Wire", "hairless": "Hairless", "curly": "Curly"]
        static let statuses: [String: String] = ["adoptable": "Adoptable", "adopted": "Adopted"]
        static let others: [String: String] = ["good_with_children": "Good with Children", "good_with_dogs": "Good with Dogs", "good_with_cats": "Good with Cats", "house_trained": "House Trained", "declawed": "Declawed", "special_needs": "Special Needs"]
    }
}
