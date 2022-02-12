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
        case timeOut
        case genericError
        case missingImage
        
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
                return "Check your internet connection."
            case .timeOut:
                return "Network timeout occurred."
            case .missingImage:
                return "Pet has no image."
            case .genericError:
                return "Something wrong. Please try later."
            }
        }
        
        static func convertError(_ error: Error?) -> Self {
            switch error?._code {
            case NSURLErrorTimedOut:
                return .timeOut
            case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
                return .noNetwork
            default:
                return .genericError
            }
        }
    }
}
