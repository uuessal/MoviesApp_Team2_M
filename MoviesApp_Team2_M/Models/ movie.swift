//
//   movie.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 03/07/1447 AH.
//
//
import Foundation

struct MovieFields: Decodable {
    let name: String
    let poster: String
    let story: String
    let runtime: String
    let genre: [String]
    let rating: String
    let IMDb_rating: Double
    let language: [String]
}


struct Movie: Decodable {
    
    
    let id: String
    let fields: MovieFields
   
}


struct MoviesResponse: Decodable {
let records: [Movie]
}
