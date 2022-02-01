//
//  AnimalCell.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import UIKit

class AnimalCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with model: Animal) {
        nameLabel.text = model.name
    }
}
