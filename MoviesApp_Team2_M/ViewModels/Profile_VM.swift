//
//  Profile_VM.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash
//

import Foundation
import Combine

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: AppUser?
    @Published var savedMovies: [Movie] = []
    @Published var isLoading = true
    @Published var errorMessage: String?
    
    func loadData(userId: String, savedMovieIds: Set<String>) async {
        isLoading = true
        do {
            // Fetch user details
            user = try await fetchUserDetailsFromAPI(userId: userId)
            
            // If no saved movie IDs, return empty
            if savedMovieIds.isEmpty {
                savedMovies = []
                isLoading = false
                return
            }
            
            // Fetch all movies
            let allMovies = try await fetchMoviesFromAPI()
            
            // Filter movies that match the saved movie IDs
            savedMovies = allMovies.filter { savedMovieIds.contains($0.id) }
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            print("Error loading profile data: \(error)")
        }
    }
}
