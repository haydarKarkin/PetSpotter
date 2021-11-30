//
//  UIImageView+Ext.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

extension UIImageView {
    
    func downloadImageFrom(link: String?, contentMode: UIView.ContentMode = .scaleAspectFit) {
        
        guard let link = link,  let imgURL = URL(string: link) else {
            self.image = UIImage.init(named: "placeholder")
            return
        }
        
        URLSession.shared.dataTask(with: imgURL) { (data, _, error) in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                
                if let data = data {
                    self.image = UIImage(data: data)
                }
                
                if error != nil {
                    self.image = UIImage.init(named: "placeholder")
                }
            }
        }.resume()
    }
}
