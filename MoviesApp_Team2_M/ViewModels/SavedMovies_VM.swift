//
//  SavedMovieViewModel.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash
//

import Foundation
import Combine

struct SavedMovieUpdateRequest: Codable {
    let fields: SavedMovieUpdateFields
}

struct SavedMovieUpdateFields: Codable {
    let movie_id: [String]
}

struct SavedMovieCreateRequest: Codable {
    let fields: SavedMovieCreateFields
}

struct SavedMovieCreateFields: Codable {
    let user_id: String
    let movie_id: [String]
}

@MainActor
class SavedMovieViewModel: ObservableObject {
    @Published var savedMovieIds: Set<String> = []
    @Published var isLoading = false
    
    func loadSavedMovies(userId: String) async {
        isLoading = true
        do {
            let allSavedMovies = try await fetchSavedMoviesFromAPI()
            
            if let userRecord = allSavedMovies.first(where: { $0.fields.user_id == userId }) {
                savedMovieIds = Set(userRecord.fields.movie_id)
            }
            
            isLoading = false
        } catch {
            print("Error loading saved movies: \(error)")
            isLoading = false
        }
    }
    
    func isSaved(_ movieId: String) -> Bool {
        return savedMovieIds.contains(movieId)
    }
    
    func saveMovie(userId: String, movieId: String) async {
        do {
            let allSavedMovies = try await fetchSavedMoviesFromAPI()
            
            if let existingRecord = allSavedMovies.first(where: { $0.fields.user_id == userId }) {
                var updatedMovieIds = existingRecord.fields.movie_id
                if !updatedMovieIds.contains(movieId) {
                    updatedMovieIds.append(movieId)
                    
                    let updateBody = SavedMovieUpdateRequest(
                        fields: SavedMovieUpdateFields(
                            movie_id: updatedMovieIds
                        )
                    )
                    
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let jsonData = try? encoder.encode(updateBody),
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("UPDATE Request JSON:\n\(jsonString)")
                    }
                    
                    let responseData = try await APIClient.put("/saved_movies/\(existingRecord.id)", body: updateBody)
                    
                    if let responseString = String(data: responseData, encoding: .utf8) {
                        print("UPDATE Response:\n\(responseString)")
                    }
                    
                    savedMovieIds.insert(movieId)
                }
            } else {
                let createBody = SavedMovieCreateRequest(
                    fields: SavedMovieCreateFields(
                        user_id: userId,
                        movie_id: [movieId]
                    )
                )
                
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                if let jsonData = try? encoder.encode(createBody),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("CREATE Request JSON:\n\(jsonString)")
                }
                
                let responseData = try await APIClient.send("/saved_movies", body: createBody)
                
                if let responseString = String(data: responseData, encoding: .utf8) {
                    print("CREATE Response:\n\(responseString)")
                }
                
                savedMovieIds.insert(movieId)
            }
        } catch {
            print("Error saving movie: \(error)")
            if let urlError = error as? URLError {
                print("URL Error code: \(urlError.code.rawValue)")
            }
        }
    }
    
    func removeMovie(userId: String, movieId: String) async {
        do {
            let allSavedMovies = try await fetchSavedMoviesFromAPI()
            
            guard let existingRecord = allSavedMovies.first(where: { $0.fields.user_id == userId }) else {
                return
            }
            
            var updatedMovieIds = existingRecord.fields.movie_id
            updatedMovieIds.removeAll { $0 == movieId }
            
            let updateBody = SavedMovieUpdateRequest(
                fields: SavedMovieUpdateFields(
                    movie_id: updatedMovieIds
                )
            )
            
            _ = try await APIClient.put("/saved_movies/\(existingRecord.id)", body: updateBody)
            savedMovieIds.remove(movieId)
        } catch {
            print("Error removing movie: \(error)")
        }
    }
    
    func toggleSave(userId: String, movieId: String) async {
        if isSaved(movieId) {
            await removeMovie(userId: userId, movieId: movieId)
        } else {
            await saveMovie(userId: userId, movieId: movieId)
        }
    }
}
