//
//  AppError.swift
//  Quiz
//
//  Created by Fábio Pontes on 17/09/2022.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding(String)
    case unknownError
    case invalidUrl(String)
    case serverError(String)
    case invalidData
    
    var errorDescription: String?{
        switch self {
        case .errorDecoding(let error):
            return "Error trying to decode: \n ----> \(error)"
        case .unknownError:
            return "Unknown error ocure"
        case .invalidUrl(let url):
            return "The URL is not valid: \n ----> \(url)  "
        case .serverError(let error):
            return error
        case .invalidData:
            return "The data returned is corrupted or is no data"
        }
    }
    
}
