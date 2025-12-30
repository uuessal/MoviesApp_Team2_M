//
//  movies.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 03/07/1447 AH.
//
import Foundation

private enum APIConfig {
    enum ConfigError: Error {
        case missingAPIKey
    }
    
    /// Reads the Airtable API key from the environment to avoid committing secrets.
    
}
func fetchMoviesFromAPI() async throws -> [Movie] {
    let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/movies")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(APIKey.airtable)", forHTTPHeaderField: "Authorization")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    if let httpResponse = response as? HTTPURLResponse {
        print("HTTP Status Code:", httpResponse.statusCode)
    }
    
    let decoded = try JSONDecoder().decode(MoviesResponse.self, from: data)
    return decoded.records
}




//
//Task {
//    do {
//        let movies = try await fetchMoviesFromAPI()
//
//        print(movies)
//    } catch {
//        print(error)
//    }
//}
