//
//  movies.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 03/07/1447 AH.
//

import Foundation


func fetchMoviesFromAPI() async throws -> [Movie] {
    let data = try await APIClient.fetch("/movies")
    let decoded = try JSONDecoder().decode(MoviesResponse.self, from: data)
    return decoded.records
}


func fetchMovieDetailsFromAPI(movieId: String) async throws -> Movie {
    let data = try await APIClient.fetch("/movies/\(movieId)")
    let decoded = try JSONDecoder().decode(Movie.self, from: data)
    return decoded
}

