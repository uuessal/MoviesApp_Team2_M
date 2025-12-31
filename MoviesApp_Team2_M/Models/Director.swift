//
//  Director.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 11/07/1447 AH.
//

import Foundation

struct DirectorFields: Decodable {
    let name: String
    let image: String
}

struct Director: Decodable, Identifiable {
    let id: String
    let fields: DirectorFields
}

struct DirectorsResponse: Decodable {
    let records: [Director]
}

struct MovieDirectorFields: Decodable {
    let movie_id: String
    let director_id: String
}

struct MovieDirector: Decodable {
    let id: String
    let fields: MovieDirectorFields
}

struct MovieDirectorsResponse: Decodable {
    let records: [MovieDirector]
}
