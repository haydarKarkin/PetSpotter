//
//  NetworkError.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//
import UIKit

class ErrorHandler {
    enum ErrorType: Error {
        case parametersNil
        case encodingFailed
        case missingURL
        case decodingFailed
        case noNetwork
        
        var message: String {
            switch self {
            case .parametersNil:
                return "Parameters were nil."
            case .encodingFailed:
                return "Parameter encoding failed."
            case .missingURL:
                return "URL is nil."
            case .decodingFailed:
                return "Can't read received data."
            case .noNetwork:
                return "Check your internet connection"
            }
        }
    }
    
    class func showAlert(source: UIViewController, failure: ErrorType, body: String? = "An error has occurred") {
        let alertVC = UIAlertController(title: failure.message, message: body, preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        source.present(alertVC, animated: true, completion: nil)
    }
}
