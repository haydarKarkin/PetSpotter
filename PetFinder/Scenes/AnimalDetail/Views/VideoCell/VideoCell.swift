//
//  VideoCell.swift
//  PetFinder
//
//  Created by hkarkin on 7.02.2022.
//

import UIKit
import WebKit

protocol VideoCellDelegate: AnyObject {
    func videoCell(_ cell: VideoCell, didCalculateHeight height: CGFloat)
}

class VideoCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heightConstraintOfWebView: NSLayoutConstraint!
    weak var delegate: VideoCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.isUserInteractionEnabled = false
        webView.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with video: Video, delegate: VideoCellDelegate?) {
        guard let embed = video.embed else { return }
        self.delegate = delegate
        webView.navigationDelegate = self
        webView.loadHTMLString(embed, baseURL: nil)
        
    }
    
}

extension VideoCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) {
        print("loaded")
        
        self.webView.scrollView.isScrollEnabled = true
        self.webView.evaluateJavaScript("document.body.scrollHeight") { [unowned self] (result, error) in
            if let tempHeight: Double = result as? Double {
                delegate?.videoCell(self, didCalculateHeight: tempHeight)
            }
        }
    }
}
