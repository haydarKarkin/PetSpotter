//
//  AnimalCell.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import UIKit

class AnimalCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animalImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderColor = UIColor(named: "PrimaryRed")?.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 8
        animalImageView.contentMode = .scaleAspectFit
    }

    func configure(with model: Animal) {
        nameLabel.text = model.name
        let imageURL = model.photos.first?.medium
        animalImageView.downloadImageFrom(link: imageURL)
    }
    
    func configure(with model: Favorite) {
        nameLabel.text = model.name
        if let imageData = model.image {
            animalImageView.image = UIImage(data: imageData) ?? UIImage(named: "AnimalPlaceholderImage")
        } else {
            animalImageView.downloadImageFrom(link: model.imageUrl?.absoluteString)
        }
    }
}
