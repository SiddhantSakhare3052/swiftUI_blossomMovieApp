//
//  DataFetcher.swift
//  BlossomMovie
//
//  Created by Siddhant Sakhare on 18/05/25.
//

import Foundation

struct DataFetcher {
    let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    
    
    // https://api.themoviewdb.org/3/trending/moview/day?api_key=YOUR_API_KEY
    func fetchTitles(for media:String) async throws -> [Title] {
        guard let baseURL = tmdbBaseURL else {
            throw NetworkErrors.missingConfig
        }
        guard let apiKey = tmdbAPIKey else {
            throw NetworkErrors.missingConfig
        }
         guard let fetchTitlesURL = URL(string: baseURL)?
            .appending(path: "3/trending/\(media)/day")
            .appending(queryItems: [
            URLQueryItem(name: "api_key", value: apiKey)
            ]) else {
             throw NetworkErrors.urlBuildFailed
         }
        
        print("fetchTitlesURL: \(fetchTitlesURL)")
        
        let (data, urlResponse) = try await URLSession.shared.data(from: fetchTitlesURL)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw  NetworkErrors.baseURLResponse(underlyingError: NSError(domain: "DataFetcher", code: (urlResponse as?  HTTPURLResponse)?.statusCode  ?? -1, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles = try decoder.decode(APIObject.self, from: data).results
        Constants.addPosterPath(to: &titles)
        return titles
    }
}
