//
//  Profile.swift
//  sing in
//
//  Created by Shahd Muharrq on 07/07/1447 AH.
//

import SwiftUI

struct Profilepage: View {
    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject var savedMovieVM: SavedMovieViewModel
    let user: AppUser

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    // Profile Button
                    if let user = viewModel.user {
                        ProfileButton(user: user)
                    }
                    
                    Text("Saved Movies")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    // Saved Movies Content
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                            .frame(maxWidth: .infinity)
                            .padding(.top, 50)
                    } else if viewModel.savedMovies.isEmpty {
                        VStack(alignment: .center, spacing: 16) {
                            Image("Empty state content")
                            
                            Text("No saved movies yet,\nstart save your favourites")
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 50)
                    } else {
                        // Display saved movies
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(viewModel.savedMovies, id: \.id) { movie in
                                ZStack(alignment: .topTrailing) {
                                    NavigationLink(destination: MoviesDetailsView(movieId: movie.id, user: user)) {
                                        AsyncImage(url: URL(string: movie.fields.poster)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 170, height: 225)
                                                .clipped()
                                                .cornerRadius(10)
                                        } placeholder: {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 170, height: 225)
                                                .cornerRadius(10)
                                                .overlay(
                                                    ProgressView()
                                                        .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                                )
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    // Remove button
                                    Button(action: {
                                        Task {
                                            await savedMovieVM.removeMovie(userId: user.id, movieId: movie.id)
                                        }
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.red)
                                            .background(Circle().fill(Color.white))
                                    }
                                    .padding(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
            }
            .navigationTitle("Profile")
            .preferredColorScheme(.dark)
            .task {
                await savedMovieVM.loadSavedMovies(userId: user.id)
                await viewModel.loadData(userId: user.id, savedMovieIds: savedMovieVM.savedMovieIds)
            }
            .onChange(of: savedMovieVM.lastUpdateTimestamp) { _ in
                // Reload when saved movies change
                Task {
                    await viewModel.loadData(userId: user.id, savedMovieIds: savedMovieVM.savedMovieIds)
                }
            }
        }
    }
}

struct ProfileButton: View {
    let user: AppUser
    
    var body: some View {
        NavigationLink(destination: ProfileInfoView(user: user)) {
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: user.fields.profile_image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 56, height: 56)
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                        )
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.fields.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(user.fields.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: 358, height: 80)
        .padding(.horizontal, 16)
        .background(Color.gray.opacity(0.26))
        .cornerRadius(8)
    }
}

#Preview {
   // Profilepage(user : user)
}
