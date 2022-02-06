//
//  ImageCell.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import UIKit

class ImageCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var mainImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: CellImageItem) {
        mainImage.downloadImageFrom(link: item.photos.first?.medium, contentMode: .scaleAspectFill)
    }
}
