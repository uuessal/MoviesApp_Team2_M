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
    
    func loadData(userId: String) async {
        do {
            // Fetch user details
            user = try await fetchUserDetailsFromAPI(userId: userId)
            
            // Fetch saved movies for this user
            savedMovies = try await fetchSavedMoviesForUser(userId: userId)
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            print("Error loading profile data: \(error)")
        }
    }
}
