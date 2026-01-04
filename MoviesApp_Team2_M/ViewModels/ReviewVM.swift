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
    
    
    func simpleDay(from isoDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // صيغة تاريخ الـ API
        
        if let date = formatter.date(from: isoDate) {
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }

}
