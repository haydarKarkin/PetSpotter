//
//  AnimalCell.swift
//  PetFinder
//
//  Created by hkarkin on 10.12.2021.
//

import UIKit

class AnimalCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Animal) {
        nameLabel.text = model.name
    }
}
