import SwiftUI
import Foundation

import Combine

@MainActor
class MoviesCenterViewModel: ObservableObject {
    
    @Published var moviesList: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func loadMovies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            moviesList = try await fetchMoviesFromAPI()
        } catch {
            errorMessage = error.localizedDescription
            print(error)
        }
        
        isLoading = false
    }
}
