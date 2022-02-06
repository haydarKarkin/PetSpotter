//
//  HeaderView.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView, Reusable {

    @IBOutlet weak var titleLabel: UILabel!

    func configure(title: String) {
        titleLabel.text = title
    }
}
