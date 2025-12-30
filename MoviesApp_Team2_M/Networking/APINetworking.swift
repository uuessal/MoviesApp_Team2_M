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

        let (data, _) = try await URLSession.shared.data(for: request)
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
    
    
    
    
}
