//
//  EditProfile.swift
//  MoviesApp_Team2_M
//
//  Created by Shahd Muharrq on 10/07/1447 AH.
//

import SwiftUI

struct ProfileInfoView: View {
    // Toggles between "view" and "edit" states
    @State private var isEditing = false
    
    
    var body: some View {
        
        NavigationStack {
                
                VStack(spacing: 20) {
                    
                    profileImage(isEditing: $isEditing)
                    
                    
                    // Card
                    infoCard(isEditing: $isEditing)
                    
                    Spacer()
                    
                    // Sign Out only in view mode
                    signoutBtn(isEditing: $isEditing)
                }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // If editing, behave like "Cancel" (or pop if you want)
                        if isEditing {
                            isEditing = false
                        } else {
                            // dismiss / pop
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundStyle(.yellow)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    //if statment short ver
                    Text(isEditing ? "Edit profile" : "Profile info")
                        .foregroundStyle(.white)
                        .font(.headline)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if isEditing {
                            // SAVE action
                            // call your VM/API here
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
    
    
}

struct profileImage: View {
    @Binding var isEditing: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.25))
                .frame(width: 90, height: 90)
            
            Image("ProfileIcon")
                .resizable()
                .frame(width: 88, height: 88)
                .foregroundStyle(.white.opacity(0.8))
            
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
    
    // Profile fields (use your real model / VM later)
    @State private var firstName = "Sarah"
    @State private var lastName  = "Abdullah"
    var body: some View {
        VStack(spacing: 0) {
            InfoRow(title: "First name", text: $firstName, isEditing: isEditing)
            
            
            Divider().background(Color.white.opacity(0.1))
            
            InfoRow(title: "Last name", text: $lastName, isEditing: isEditing)
            
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
        // if false do this
        if !isEditing {
            Button(role: .destructive) {
                // sign out logic
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
    ProfileInfoView()
}
