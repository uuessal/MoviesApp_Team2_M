//
//  SavedMovie.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash
//

import Foundation

struct SavedMovieFields: Decodable {
    let user_id: String
    let movie_id: [String]  // Array of movie IDs
}

struct SavedMovie: Decodable {
    let id: String
    let fields: SavedMovieFields
}

struct SavedMoviesResponse: Decodable {
    let records: [SavedMovie]
}
