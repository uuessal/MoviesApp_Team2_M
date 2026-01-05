//
//  MoviesApp_Team2_MApp.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 23/12/2025.
//

import SwiftUI

@main
struct MoviesApp_Team2_MApp: App {
    @StateObject private var savedMovieVM = SavedMovieViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SigninPage()
            }
            .environmentObject(savedMovieVM)
        }
    }
}
