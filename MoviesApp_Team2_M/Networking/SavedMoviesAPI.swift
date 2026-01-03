//
//  SavedMoviesAPI.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 14/07/1447 AH.
//


import Foundation

// Fetch all saved movies
func fetchSavedMoviesFromAPI() async throws -> [SavedMovie] {
    let data = try await APIClient.fetch("/saved_movies")
    let decoded = try JSONDecoder().decode(SavedMoviesResponse.self, from: data)
    return decoded.records
}

// Fetch saved movies for a specific user
func fetchSavedMoviesForUser(userId: String) async throws -> [Movie] {
    // Step 1: Get all saved movie records
    let allSavedMovies = try await fetchSavedMoviesFromAPI()
    
    // Step 2: Filter for this user
    let userSavedMovies = allSavedMovies.filter { $0.fields.user_id == userId }
    
    // Step 3: Extract all movie IDs
    let movieIds = userSavedMovies.flatMap { $0.fields.movie_id }
    
    // Step 4: If no saved movies, return empty array
    if movieIds.isEmpty {
        return []
    }
    
    // Step 5: Fetch all movies
    let allMovies = try await fetchMoviesFromAPI()
    
    // Step 6: Filter movies that match the saved movie IDs
    let savedMovies = allMovies.filter { movieIds.contains($0.id) }
    
    return savedMovies
}
