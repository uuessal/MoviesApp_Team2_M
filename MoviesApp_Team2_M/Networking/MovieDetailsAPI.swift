//
//  MovieDetailsNetworking.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 11/07/1447 AH.
//

import Foundation

// Fetch all directors
func fetchDirectorsFromAPI() async throws -> [Director] {
    let data = try await APIClient.fetch("/directors")
    let decoded = try JSONDecoder().decode(DirectorsResponse.self, from: data)
    return decoded.records
}

// Fetch all movie-director relationships
func fetchMovieDirectorsRelationshipsFromAPI() async throws -> [MovieDirector] {
    let data = try await APIClient.fetch("/movie_directors")
    let decoded = try JSONDecoder().decode(MovieDirectorsResponse.self, from: data)
    return decoded.records
}

// Fetch directors for a specific movie
func fetchDirectorsForMovie(movieId: String) async throws -> [Director] {
    // Fetch all relationships
    let relationships = try await fetchMovieDirectorsRelationshipsFromAPI()
    
    // Filter relationships for this movie
    let movieRelationships = relationships.filter { $0.fields.movie_id == movieId }
    
    // If no directors found, return empty array
    if movieRelationships.isEmpty {
        return []
    }
    
    // Get director IDs for this movie
    let directorIds = movieRelationships.map { $0.fields.director_id }
    
    // Fetch all directors
    let allDirectors = try await fetchDirectorsFromAPI()
    
    // Filter directors based on the IDs
    let movieDirectors = allDirectors.filter { directorIds.contains($0.id) }
    
    return movieDirectors
}
