//
//  APINetworking.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 10/07/1447 AH.
//

import Foundation

struct APIClient {

    private static let baseURL = "https://api.airtable.com/v0/appsfcB6YESLj4NCN"

    static func fetch(_ endpoint: String) async throws -> Data {
        guard let url = URL(string: baseURL + endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(APIKey.airtable)",
            forHTTPHeaderField: "Authorization"
        )

        let (data, response) = try await URLSession.shared.data(for: request)
        
//        guard let url = components.url else {
//                    throw NetworkError.invalidURL
//                }
//
//                let (data, response) = try await URLSession.shared.data(from: url)
//
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    throw NetworkError.invalidResponse
//                }
//
//                guard (200...299).contains(httpResponse.statusCode) else {
//                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
//                }
//
//                do {
//                    return try JSONDecoder().decode([User].self, from: data)
//                } catch {
//                    throw NetworkError.decodingFailed
//                }
        
    
        return data
        
        
    }
    
    
    
    static func post(_ endpoint: String) async throws -> Data {
        guard let url = URL(string: baseURL + endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("Bearer \(APIKey.airtable)",forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    
    static func put(_ endpoint: String) async throws -> Data {
        guard let url = URL(string: baseURL + endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.setValue("Bearer \(APIKey.airtable)",forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    
    
    
}
