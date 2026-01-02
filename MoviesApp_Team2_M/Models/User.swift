//
//  User.swift
//  MoviesApp_Team2_M
//
//  Created by Shahd Muharrq on 13/07/1447 AH.
//
import Foundation

struct UserFields: Codable {
    let name: String
    let password: String
    let email: String
    let profile_image: String
    
    
}

struct UserResponse: Codable {
    let records: [AppUser]
}



struct AppUser: Codable {
    
    let id: String
    let fields: UserFields
    
}



