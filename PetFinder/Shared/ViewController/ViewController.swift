//
//  ViewController.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

class ViewController<T: ViewModelType>: UIViewController {
    
    var viewModel: T!
    var activityViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bindViewModel()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
    }
    
    func makeUI() {
        updateUI()
    }
    
    func bindViewModel() {
        
        viewModel.onLoadHandling = { [weak self] (isLoading) in
            guard let self = self else { return }
            if isLoading {
                self.showActivityIndicator(onView: self.view)
            } else {
                self.hideActivityIndicator()
            }
        }
        
        viewModel.onErrorHandling = { [weak self] (error) in
            self?.showAlert()
        }
    }
    
    func updateUI() {}
}

extension ViewController {
    
    func showActivityIndicator(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        activityViews.append(spinnerView)
        view.isUserInteractionEnabled = false
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityViews.popLast()?.removeFromSuperview()
        }
        view.isUserInteractionEnabled = true
    }
    
    func showAlert( with title: String = Configs.Text.globalErrorTitle,
                    message: String = Configs.Text.globalErrorDesc) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })))
        
        self.present(alert, animated: true, completion: nil)
    }
}
