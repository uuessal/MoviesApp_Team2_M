//
//  ReviewsAPI.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 30/12/2025.
//

import Foundation

// MARK: - Fetch Reviews
func fetchReviewsFromAPI(movieId: String) async throws -> [Review] {
    
    let urlString = "/reviews?filterByFormula={movie_id}=\"\(movieId)\""
    
    let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
    
    let data = try await APIClient.fetch(encodedUrl)
    let decoded = try JSONDecoder().decode(ReviewsResponse.self, from: data)
    return decoded.records
}

func sendReview(reviewFields: ReviewFields) async throws -> Review {
    let body = ReviewRequest(fields: reviewFields)
    
    let data = try await APIClient.send("/reviews", body: body)
    return try JSONDecoder().decode(Review.self, from: data)
}
