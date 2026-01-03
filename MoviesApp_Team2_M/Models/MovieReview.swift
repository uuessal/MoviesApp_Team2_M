//
//  MovieReview.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 30/12/2025.
//

import Foundation

struct ReviewFields: Codable {
  
    let rate : Double
    let review_text : String
    let movie_id : String
    let user_id : String
    
}


struct Review: Codable {
    let id: String
    let fields: ReviewFields
   
}


struct ReviewsResponse: Decodable {
let records: [Review]
}

struct ReviewRequest: Encodable {
    let fields: ReviewFields
}
