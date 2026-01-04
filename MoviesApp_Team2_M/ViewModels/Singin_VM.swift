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
        print("signIn step 1")
        guard !email.isEmpty, !password.isEmpty else { return }

        errorMessage = nil

        do {
            let users = try await fetchUserFromAPI()

            print("signIn step 2")

            if let matchedUser = users.first(where: {
                $0.fields.email.lowercased() == email.lowercased() &&
                $0.fields.password == password
            }) {
                print("signIn step 3")

                self.user = matchedUser
            } else {
                errorMessage = "Invalid email or password"
            }

        } catch {
            print("signIn step 4")

            errorMessage = "Login failed"
        }
    }

}
