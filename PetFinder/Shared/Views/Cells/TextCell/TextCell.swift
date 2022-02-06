//
//  TextCell.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import UIKit

class TextCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.numberOfLines = 0
        descLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: CellTextItem) {
        titleLabel.text = item.title
        descLabel.text = item.description
    }
    
}
