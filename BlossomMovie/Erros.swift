//
//  Erros.swift
//  BlossomMovie
//
//  Created by Siddhant Sakhare on 18/05/25.
//

import Foundation

enum APIClientError: Error {
    case fileNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File not found"
        case .dataLoadingFailed(underlyingError: let error):
            return "Failed to load data from API configuration file: \(error.localizedDescription)"
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode API configuration: \(error.localizedDescription)"
        }
    }
}

enum NetworkErrors: Error, LocalizedError {
    case baseURLResponse(underlyingError: Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case .baseURLResponse(underlyingError: let error):
            return "Failed to get base URL response: \(error.localizedDescription)"
        case .missingConfig:
            return "Missing required configuration"
        case .urlBuildFailed:
            return "Failed to build url"
        }
    }
}
