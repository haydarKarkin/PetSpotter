//
//  AnimalsVC.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

// MARK: AnimalsVC

class AnimalsVC: ViewController<AnimalsVM> {

    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var animals: [Animal] = [Animal]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - VM Binders
    var nextClosure: (() -> Void)?
    var getAnimalsClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        
        // setup tableviewe
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = Configs.UI.estimatedRowHeight
        tableView.registerCellNib(AnimalCell.self)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let animalClosure: (([Animal]) -> Void)? = { [weak self] (result) in
            DispatchQueue.main.async {
                self?.animals = result
            }
        }
        
        let input = AnimalsVM.Input(animals: animalClosure)
        
        viewModel.transform(input: input){ (output) in
            self.nextClosure = output.next
            self.getAnimalsClosure = output.getAnimals
        }
        getAnimalsClosure?()
    }
}

// MARK: - Storyboarded
extension AnimalsVC: Storyboarded {
    static var storyboardName = StoryboardName.animal
}

// MARK: - UITableViewDataSource
extension AnimalsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AnimalCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(with: animals[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AnimalsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let isReachedBottom = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        if isReachedBottom {
            nextClosure?()
        }
    }
}
