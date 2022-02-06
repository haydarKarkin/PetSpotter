//
//  ButtonCell.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import UIKit

class ButtonCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: CellButtonItem) {
        button.setTitle(item.title, for: .normal)
    }
    
}
