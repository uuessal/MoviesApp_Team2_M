//
//  User.swift
//  MoviesApp_Team2_M
//
//  Created by Shahd Muharrq on 13/07/1447 AH.
//

import Foundation


func fetchUserFromAPI() async throws -> [AppUser] {
    let data = try await APIClient.fetch("/users")
    
    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
    guard let recordsArray = json?["records"] as? [[String: Any]] else {
        throw URLError(.badServerResponse)
    }
    
    var validUsers: [AppUser] = []
    
    for (index, record) in recordsArray.enumerated() {
        do {
            let recordData = try JSONSerialization.data(withJSONObject: record)
            let user = try JSONDecoder().decode(AppUser.self, from: recordData)
            validUsers.append(user)
        } catch {
            print("⚠️ Skipping invalid user at index \(index): \(error.localizedDescription)")
            // Skip this broken record and continue
        }
    }
    
    print("✅ Loaded \(validUsers.count) valid users (skipped \(recordsArray.count - validUsers.count) broken records)")
    return validUsers
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
