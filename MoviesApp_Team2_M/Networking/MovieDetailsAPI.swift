//
//  MovieDetailsNetworking.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 11/07/1447 AH.
//

import Foundation

//DIRECTORS
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


//ACTORS
// Fetch all actors
func fetchActorsFromAPI() async throws -> [Actor] {
    let data = try await APIClient.fetch("/actors")
    let decoded = try JSONDecoder().decode(ActorsResponse.self, from: data)
    return decoded.records
}

// Fetch all movie-actor relationships
func fetchMovieActorsRelationshipsFromAPI() async throws -> [MovieActor] {
    let data = try await APIClient.fetch("/movie_actors")
    let decoded = try JSONDecoder().decode(MovieActorsResponse.self, from: data)
    return decoded.records
}

// Fetch actors for a specific movie
func fetchActorsForMovie(movieId: String) async throws -> [Actor] {
    // Fetch all relationships
    let relationships = try await fetchMovieActorsRelationshipsFromAPI()
    
    // Filter relationships for this movie
    let movieRelationships = relationships.filter { $0.fields.movie_id == movieId }
    
    // If no actors found, return empty array
    if movieRelationships.isEmpty {
        return []
    }
    
    // Get actor IDs for this movie
    let actorIds = movieRelationships.map { $0.fields.actor_id }
    
    // Fetch all actors
    let allActors = try await fetchActorsFromAPI()
    
    // Filter actors based on the IDs
    let movieActors = allActors.filter { actorIds.contains($0.id) }
    
    return movieActors
}
