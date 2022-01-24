//
//  OrganizationCell.swift
//  PetFinder
//
//  Created by hkarkin on 24.01.2022.
//

import UIKit

class OrganizationCell: UITableViewCell, Reusable {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with model: Organization) {
        nameLabel.text = model.name
    }
    
}
