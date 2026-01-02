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
    let decoded = try JSONDecoder().decode(AppUser.self, from: data)
    return decoded
}



