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
    @Published var isSending: Bool = false
    @Published var errorMessage: String?

    func sendingReview(_ reviewFields: ReviewFields) async throws {
        isSending = true
        errorMessage = nil
        
        do {
            _ = try await sendReview(reviewFields: reviewFields)
        } catch {
            errorMessage = error.localizedDescription
            print("Failed to post review:", error)
            throw error
        }
        
        isSending = false
    }
}
