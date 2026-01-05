//
//  ReviewVM.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 03/01/2026.
//

import SwiftUI
import Foundation

import Combine

@MainActor
class ReviewViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func addReview(
        rating: Int,
        reviewText: String,
        movieId: String,
        userId: String
    ) async {
        
        do {
            isLoading = true
            
            let reviewFields = ReviewFields(
                rate: Double(rating),
                review_text: reviewText,
                movie_id: movieId,
                user_id: userId
            )
            
            let _ = try await sendReview(reviewFields: reviewFields)
            
            isLoading = false
            
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            print("Error adding review: \(error)")
        }
    }
    
    
    func simpleDay(from isoDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" 
        
        if let date = formatter.date(from: isoDate) {
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}
