//
//  FavoritesVC.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import UIKit

class FavoritesVC: ViewController<FavoritesVM> {
    
    // MARK: - UI Elements
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var favorites: [Favorite] = [Favorite]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - VM Binders
    var getFavoritesClosure: (() -> Void)?
    var openAnimalDetailClosure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoritesClosure?()
    }
    
    override func makeUI() {
        super.makeUI()
        title = "Favorites"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCellNib(AnimalCell.self)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let favoriteClosure: (([Favorite]) -> Void)? = { [weak self] (result) in
            DispatchQueue.main.async {
                self?.favorites = result
            }
        }
        
        let input = FavoritesVM.Input(favorites: favoriteClosure)
        viewModel.transform(input: input) { (output) in
            self.getFavoritesClosure = output.getFavorites
            self.openAnimalDetailClosure = output.openAnimalDetail
        }
    }
}

// MARK: - Storyboarded
extension FavoritesVC: Storyboarded {
    static var storyboardName = StoryboardName.favorite
}

// MARK: - UICollectionViewDataSource
extension FavoritesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if favorites.isEmpty {
            self.collectionView.setEmptyMessage(Configs.Text.userNoFavorite)
        } else {
            self.collectionView.restore()
        }
        
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnimalCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(with: favorites[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        openAnimalDetailClosure?(favorites[indexPath.row].id!)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
}
