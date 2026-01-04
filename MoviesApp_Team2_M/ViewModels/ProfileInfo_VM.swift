//
//  ProfileInfo_VM.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 15/07/1447 AH.
//


import Foundation
import Combine

@MainActor
class ProfileInfoViewModel: ObservableObject {
    @Published var user: AppUser
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    
    init(user: AppUser) {
        self.user = user
        
        // Split name into first and last
        let nameParts = user.fields.name.split(separator: " ")
        firstName = String(nameParts.first ?? "")
        lastName = nameParts.count > 1 ? String(nameParts.last ?? "") : ""
    }
    
    func saveChanges() async {
        print("Step 1: Starting to save changes...")
        isLoading = true
        errorMessage = nil
        successMessage = nil
        
        // Combine first and last name
        let fullName = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
        
        print("Step 2: Preparing data...")
        print("   User ID: \(user.id)")
        print("   Full Name: \(fullName)")
        print("   Email: \(user.fields.email)")
        print("   Password: \(user.fields.password ?? "nil")")
        print("   Profile Image: \(user.fields.profile_image)")
        
        do {
            print("Step 3: Calling API...")
            
            let updatedUser = try await updateUserFromAPI(
                userId: user.id,
                name: fullName,
                email: user.fields.email,
                password: user.fields.password ?? "",  // Unwrap with default empty string
                profileImage: user.fields.profile_image
            )
            
            print("Step 4: Save successful!")
            self.user = updatedUser
            successMessage = "Profile updated successfully"
            isLoading = false
            
        } catch {
            print("Step 5: Save failed!")
            print("   Error: \(error)")
            errorMessage = "Failed to update profile"
            isLoading = false
        }
    }
}
