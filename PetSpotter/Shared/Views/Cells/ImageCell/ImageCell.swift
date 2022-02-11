//
//  ImageCell.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import UIKit

protocol ImageCellDelegate: AnyObject {
    func imageDownloadFinish(with error: Error?)
}

class ImageCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var mainImage: UIImageView!
    weak var delegate: ImageCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: CellImageItem, delegate: ImageCellDelegate?) {
        self.delegate = delegate
        mainImage.downloadImageFrom(link: item.photos.first?.medium, contentMode: .scaleAspectFill) { error in
            delegate?.imageDownloadFinish(with: error)
        }
    }
}
