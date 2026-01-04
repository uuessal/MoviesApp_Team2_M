//
//  User.swift
//  MoviesApp_Team2_M
//
//  Created by Shahd Muharrq on 13/07/1447 AH.
//

import Foundation


func fetchUserFromAPI() async throws -> [AppUser] {
    let data = try await APIClient.fetch("/users")
    let decoded = try JSONDecoder().decode(UserResponse.self, from: data)
    return decoded.records
}

func fetchUserDetailsFromAPI(userId: String) async throws -> AppUser {
    let data = try await APIClient.fetch("/users/\(userId)")
    //
    let decoded = try JSONDecoder().decode(AppUser.self, from: data)
    return decoded
}



// Update user information
func updateUserFromAPI(userId: String, name: String, email: String, password: String?, profileImage: String) async throws -> AppUser {
    
    // Create the request body structure
    struct UpdateUserBody: Encodable {
        let fields: UserFields
    }
    
    let body = UpdateUserBody(fields: UserFields(
        name: name,
        password: password,  // Keep it optional
        email: email,
        profile_image: profileImage
    ))
    
    print("📡 Sending PUT request to /users/\(userId)")
    print("   Body: name=\(name), email=\(email)")
    
    // Send PUT request
    let data = try await APIClient.put("/users/\(userId)", body: body)
    let decoded = try JSONDecoder().decode(AppUser.self, from: data)
    
    print("✅ User updated successfully!")
    return decoded
}
