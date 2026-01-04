//
//  ProfileInfoView.swift
//  MoviesApp_Team2_M
//
//  Created by Shahd Muharrq on 10/07/1447 AH.

import SwiftUI

struct ProfileInfoView: View {
    let user: AppUser  // Accept user data
    
    @State private var isEditing = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            profileImage(isEditing: $isEditing, imageURL: user.fields.profile_image)
            
            // Card
            infoCard(isEditing: $isEditing, user: user)
            
            Spacer()
            
            // Sign Out only in view mode
            signoutBtn(isEditing: $isEditing)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(isEditing ? "Edit profile" : "Profile info")
                    .foregroundStyle(.white)
                    .font(.headline)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if isEditing {
                        // SAVE action - call your API here
                        isEditing = false
                    } else {
                        isEditing = true
                    }
                } label: {
                    Text(isEditing ? "Save" : "Edit")
                        .foregroundStyle(.yellow)
                }
            }
        }
    }
}

struct profileImage: View {
    @Binding var isEditing: Bool
    let imageURL: String
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 90, height: 90)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    )
            }
            
            if isEditing {
                Circle()
                    .fill(Color.black.opacity(0.7))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "camera.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.yellow)
                    )
                    .offset(x: 28, y: 28)
            }
        }
    }
}


struct infoCard: View {
    @Binding var isEditing: Bool
    let user: AppUser
    
    // Split the name into first and last name
    @State private var firstName = ""
    @State private var lastName = ""
    
    var body: some View {
        VStack(spacing: 0) {
            InfoRow(title: "First name", text: $firstName, isEditing: isEditing)
            
            Divider().background(Color.white.opacity(0.1))
            
            InfoRow(title: "Last name", text: $lastName, isEditing: isEditing)
            
            Divider().background(Color.white.opacity(0.1))
            
            // Email (read-only)
            HStack {
                Text("Email")
                    .foregroundStyle(.white.opacity(0.85))
                Spacer()
                Text(user.fields.email)
                    .foregroundStyle(.white.opacity(0.6))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(Color.white.opacity(0.08))
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .onAppear {
            // Split name into first and last
            let nameParts = user.fields.name.split(separator: " ")
            firstName = String(nameParts.first ?? "")
            lastName = nameParts.count > 1 ? String(nameParts.last ?? "") : ""
        }
    }
}

struct InfoRow: View {
    let title: String
    @Binding var text: String
    let isEditing: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.white.opacity(0.85))
            Spacer()
            if isEditing {
                TextField("", text: $text)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.white)
                    .accentColor(.yellow)
            } else {
                Text(text)
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

struct signoutBtn : View {
    @Binding var isEditing: Bool
    
    var body: some View{
        if !isEditing {
            Button(role: .destructive) {
                // TODO: sign out logic
            } label: {
                Text("Sign Out")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.white.opacity(0.12))
            .foregroundStyle(.red)
            .padding(.horizontal, 16)
            .padding(.bottom, 18)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileInfoView(user: AppUser(
            id: "recaLvl1OOPjSagCx",
            fields: UserFields(
                name: "Sarah Abdullah",
                password: "password",
                email: "sarah@example.com",
                profile_image: "https://source.unsplash.com/200x200/?person"
            )
        ))
    }
}
