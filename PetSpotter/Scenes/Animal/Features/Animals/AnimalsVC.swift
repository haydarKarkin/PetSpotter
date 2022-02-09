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
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var animals: [Animal] = [Animal]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - VM Binders
    var nextClosure: (() -> Void)?
    var getAnimalsClosure: (() -> Void)?
    var openDetailClosure: ((Animal) -> Void)?
    var openFilterClosre: ((AnimalsVC) -> Void)?
    var searchAnimalsClosure: ((Filter) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        
        title = "Animals"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCellNib(AnimalCell.self)
        
        let filter = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"),
                        style: .plain,
                        target: self,
                        action: #selector(openFilter))
        navigationItem.rightBarButtonItems = [filter]
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
            self.openDetailClosure = output.openDetail
            self.openFilterClosre = output.openFilter
            self.searchAnimalsClosure = output.searchAnimals
        }
        getAnimalsClosure?()
    }
    
    @objc
    func openFilter() {
        openFilterClosre?(self)
    }
}

// MARK: - Storyboarded
extension AnimalsVC: Storyboarded {
    static var storyboardName = StoryboardName.animal
}

// MARK: - UICollectionViewDataSource
extension AnimalsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnimalCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(with: animals[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension AnimalsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let isReachedBottom = indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        if isReachedBottom {
            nextClosure?()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        openDetailClosure?(animals[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AnimalsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
}

// MARK: - AnimalFilterDelegate
extension AnimalsVC: AnimalFilterDelegate {
    func searchTapped(with filter: Filter) {
        searchAnimalsClosure?(filter)
    }
}
