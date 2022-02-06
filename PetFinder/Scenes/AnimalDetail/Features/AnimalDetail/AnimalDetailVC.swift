//
//  AnimalDetailVC.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import UIKit

class AnimalDetailVC: ViewController<AnimalDetailVM> {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var tableAdapter: TableAdapter!
    var isFavorited: Bool = false {
        didSet {
            configureNavigationItem(with: isFavorited)
        }
    }
    
    // MARK: - VM Binders
    var getFavoriteClosure: (() -> Void)?
    var saveFavoriteClosure: (() -> Void)?
    var deleteFavoriteClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let isFavoritedClosure: ((Bool) -> Void)? = { [weak self] (result) in
            DispatchQueue.main.async {
                self?.isFavorited = result
            }
        }
        
        let input = AnimalDetailVM.Input(isFavorited: isFavoritedClosure)
        
        viewModel.transform(input: input){ [weak self] (output) in
            guard let self = self else { return }
            self.title = output.animal.name
            self.getFavoriteClosure = output.getFavorite
            self.saveFavoriteClosure = output.saveFavorite
            self.deleteFavoriteClosure = output.deleteFavorite
            self.tableAdapter = TableAdapter(tableView: self.tableView, delegate: self, animal: output.animal)
            self.tableAdapter.reload()
        }
        getFavoriteClosure?()
    }
    
    @objc
    func saveFavorite() {
        saveFavoriteClosure?()
    }
    
    @objc
    func deleteFavorite() {
        deleteFavoriteClosure?()
    }
    
    func configureNavigationItem(with isFavorited: Bool) {
        if isFavorited {
            let deleteFavorite = UIBarButtonItem(image: UIImage(systemName: "star.fill"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(deleteFavorite))
            navigationItem.rightBarButtonItems = [deleteFavorite]
        } else {
            let saveFavorite = UIBarButtonItem(image: UIImage(systemName: "star"),
                                               style: .plain,
                                               target: self,
                                               action: #selector(saveFavorite))
            navigationItem.rightBarButtonItems = [saveFavorite]
        }
    }
}

// MARK: - Storyboarded
extension AnimalDetailVC: Storyboarded {
    static var storyboardName = StoryboardName.animalDetail
}

// MARK: - AnimalDetailVCTableAdapterDelegate
extension AnimalDetailVC: AnimalDetailVCTableAdapterDelegate {
    
}
