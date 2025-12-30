//
//  Token.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 10/07/1447 AH.
//
import SwiftUI

enum APIKey {
    static let airtable = Bundle.main
        .infoDictionary?["AIRTABLE_API_KEY"] as? String ?? ""
}
