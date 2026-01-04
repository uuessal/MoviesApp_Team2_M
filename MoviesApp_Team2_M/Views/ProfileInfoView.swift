//
//  ProfileInfoView.swift
//  MoviesApp_Team2_M
//
//  Created by Shahd Muharrq on 10/07/1447 AH.
//

import SwiftUI

struct ProfileInfoView: View {
    @StateObject private var viewModel: ProfileInfoViewModel
    @State private var isEditing = false
    
    init(user: AppUser) {
        _viewModel = StateObject(wrappedValue: ProfileInfoViewModel(user: user))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            profileImage(isEditing: $isEditing, imageURL: viewModel.user.fields.profile_image)
            
            // Card
            infoCard(
                isEditing: $isEditing,
                firstName: $viewModel.firstName,
                lastName: $viewModel.lastName,
                email: viewModel.user.fields.email
            )
            
            // Show success/error messages
            if let successMessage = viewModel.successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .font(.caption)
                    .padding(.top, 8)
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 8)
            }
            
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
                        // SAVE action
                        Task {
                            await viewModel.saveChanges()
                            if viewModel.errorMessage == nil {
                                isEditing = false
                            }
                        }
                    } else {
                        isEditing = true
                    }
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                            .scaleEffect(0.8)
                    } else {
                        Text(isEditing ? "Save" : "Edit")
                            .foregroundStyle(.yellow)
                    }
                }
                .disabled(viewModel.isLoading)
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
                    .fill(Color.gray.opacity(0.25))
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
    @Binding var firstName: String
    @Binding var lastName: String
    let email: String
    
    var body: some View {
        VStack(spacing: 0) {
            InfoRow(title: "First name", text: $firstName, isEditing: isEditing)
            
            Divider().background(Color.white.opacity(0.1))
            
            InfoRow(title: "Last name", text: $lastName, isEditing: isEditing)
            
            Divider().background(Color.white.opacity(0.1))
            
            HStack {
                Text("Email")
                    .foregroundStyle(.white.opacity(0.85))
                Spacer()
                Text(email)
                    .foregroundStyle(.white.opacity(0.6))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(Color.white.opacity(0.08))
        .cornerRadius(10)
        .padding(.horizontal, 16)
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
            id: "recmkWslbkyjQly3f",
            fields: UserFields(
                name: "Wafaa Ahmad",
                password: "Wafaa@gmail.com",
                email: "Wafaa@gmail.com",
                profile_image: "https://i.pinimg.com/736x/0d/50/63/0d5063654b6e1a1bbbe4e637061b15ce.jpg"
            )
        ))
    }
}
