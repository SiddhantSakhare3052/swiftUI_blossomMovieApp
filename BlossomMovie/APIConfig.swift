//
//  APIConfig.swift
//  BlossomMovie
//
//  Created by Siddhant Sakhare on 18/05/25.
//

import Foundation

struct APIConfig: Decodable {
    let tmdbBaseURL: String
    let tmdbAPIKey: String
    
    static let shared: APIConfig? = {
        do {
            return try loadConfig()
        } catch {
            print("Failed to load API config: \(error.localizedDescription)")
            return nil
        }
    }()
    
    private static func loadConfig() throws -> APIConfig {
        guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "json") else {
            throw APIClientError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(APIConfig.self, from: data)
        } catch let error {
            throw APIClientError.decodingFailed(underlyingError: error)
        } catch {
            throw APIClientError.dataLoadingFailed(underlyingError: error)
        }
        
    }
}
