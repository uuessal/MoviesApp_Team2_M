//
//  MovieDetails_VM.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash
//

import Combine
import Foundation

@MainActor
class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var directors: [Director] = []
    @Published var actors: [Actor] = []
    @Published var reviewsList: [Review] = []
    @Published var usersList: [AppUser] = []
    @Published var isLoading = true
    @Published var errorMessage: String?
    @Published var showDeleteSuccessAlert = false
    @Published var deleteSuccessMessage = ""
    
    func loadData(movieId: String) async {
        do {
            // Fetch movie details
            movie = try await fetchMovieDetailsFromAPI(movieId: movieId)
            
            // Fetch directors for this movie
            directors = try await fetchDirectorsForMovie(movieId: movieId)
            
            // Fetch actors for this movie
            actors = try await fetchActorsForMovie(movieId: movieId)
            
            // Fetch reviews
            reviewsList = try await fetchReviewsFromAPI(movieId: movieId)
            
            usersList = try await fetchUserFromAPI()
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            print("Error loading data: \(error)")
        }
    }
    
    func deleteReview(reviewId: String) async {
        do {
            try await deleteReviewFromAPI(reviewId: reviewId)

            reviewsList.removeAll { $0.id == reviewId }
            
            // message for the user
            deleteSuccessMessage = "Your review has been deleted successfully."
            showDeleteSuccessAlert = true

        } catch {
            errorMessage = "Failed to delete the review. Please try again."
        }
    }

}
