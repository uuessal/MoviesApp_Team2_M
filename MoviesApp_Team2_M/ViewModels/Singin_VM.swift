//
//  Singin_VM.swift
//  MoviesApp_Team2_M
//
//  Created by Shahd Muharrq on 14/07/1447 AH.
//

import SwiftUI
import Combine

@MainActor
class SigninViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorMessage: String?
    @Published var user: AppUser?
    
    func signIn() async {
        print("Step 1: Starting sign in")
        print("   Email: \(email)")
        print("   Password: \(password)")
        
        guard !email.isEmpty, !password.isEmpty else {
            print("❌ Empty email or password")
            errorMessage = "Please enter email and password"
            return
        }

        errorMessage = nil

        do {
            print("Step 2: Fetching users from API...")
            let users = try await fetchUserFromAPI()
            print("Step 3: Got \(users.count) users")
            
            // Print all users for debugging
            for (index, user) in users.enumerated() {
                print("   User \(index + 1): \(user.fields.email) / \(user.fields.password ?? "NO PASSWORD")")
            }
            
            print("Step 4: Searching for match...")
            print("   Looking for email: \(email.lowercased())")
            print("   Looking for password: \(password)")

            if let matchedUser = users.first(where: {
                $0.fields.email.lowercased() == email.lowercased() &&
                $0.fields.password == password  // This will only match if password exists and matches
            }) {
                print("Step 5: Login successful!")
                print("   User ID: \(matchedUser.id)")
                print("   User Name: \(matchedUser.fields.name)")
                
                self.user = matchedUser
            } else {
                print("Step 5: No matching user found")
                errorMessage = "Invalid email or password"
            }

        } catch {
            print("Step 6: API Error")
            print("   Error: \(error)")
            print("   Error description: \(error.localizedDescription)")
            errorMessage = "Login failed: \(error.localizedDescription)"
        }
    }
}
