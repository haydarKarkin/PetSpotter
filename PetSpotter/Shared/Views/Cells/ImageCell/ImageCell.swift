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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    weak var delegate: ImageCellDelegate?
    var isImageFetched = false

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
        if isImageFetched { return }
        indicator.startAnimating()
        mainImage.downloadImageFrom(link: item.photos.first?.medium, contentMode: .scaleAspectFill) { [weak self] error in
            self?.indicator.stopAnimating()
            self?.isImageFetched = true
            delegate?.imageDownloadFinish(with: error)
        }
    }
}
