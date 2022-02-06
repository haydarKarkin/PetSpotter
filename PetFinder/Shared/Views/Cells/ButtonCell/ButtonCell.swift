//
//  ButtonCell.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import UIKit

protocol ButtonCellDelegate: AnyObject {
    func animalDetailTapped(id: String)
    func organizationDetailTapped(id: String)
    func videosTapped(videos: [Video])
}

class ButtonCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var button: UIButton!
    weak var delegate: ButtonCellDelegate?
    var item: CellButtonItem?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: CellButtonItem, delegate: ButtonCellDelegate) {
        self.delegate = delegate
        self.item = item
        button.setTitle(item.title, for: .normal)
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        guard let item = item else { return }
        switch item.action {
        case .animalDetail(let id):
            delegate?.animalDetailTapped(id: id)
        case .organizationDetail(let id):
            delegate?.organizationDetailTapped(id: id)
        case .video(let videos):
            delegate?.videosTapped(videos: videos)
        }
    }
}
