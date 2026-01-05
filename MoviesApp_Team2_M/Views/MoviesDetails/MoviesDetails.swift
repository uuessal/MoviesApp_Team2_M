//
//  MoviesDetails.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 04/07/1447 AH.
//

import SwiftUI

// Main View
struct MoviesDetailsView: View {
    
    @StateObject private var viewModel = MovieDetailsViewModel()
    @EnvironmentObject var savedMovieVM: SavedMovieViewModel
    let movieId: String
    let user: AppUser
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 100)
            } else if let movie = viewModel.movie {
                VStack(alignment: .leading, spacing: 24) {

                    HeaderImageSection(
                        posterURL: movie.fields.poster,
                        title: movie.fields.name,
                        movieId: movieId,
                        isSaved: savedMovieVM.isSaved(movieId),
                        onSave: {
                            await savedMovieVM.saveMovie(userId: user.id, movieId: movieId)
                        }
                    )

                    MovieInfoGrid(
                        duration: movie.fields.runtime,
                        language: movie.fields.language.joined(separator: ", "),
                        genre: movie.fields.genre.joined(separator: ", "),
                        age: movie.fields.rating
                    )

                    StorySection(story: movie.fields.story)

                    IMDBRatingSection(rating: movie.fields.IMDb_rating)

                    DirectorSection(directors: viewModel.directors)

                    CastSection(actors: viewModel.actors)

                    ReviewsSection(ReviewsList: viewModel.reviewsList,
                                   userList: viewModel.usersList,
                                   rating: movie.fields.IMDb_rating,
                                   currentUserId: user.id,  
                                   onDeleteReview: { reviewId in
                                           await viewModel.deleteReview(reviewId: reviewId)
                                       }
                                   )
                    
                    WriteReviewButton(movieId: movieId, user: user)
                }
                .padding(.bottom, 32)
                
            }
            else if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 50))
                        .foregroundColor(.yellow)
                    
                    Text("Error loading movie")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Text(errorMessage)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 100)
            }
        }
        .background(Color.black)
        .ignoresSafeArea(edges: .top)
        .task {
            await viewModel.loadData(movieId: movieId)
            await savedMovieVM.loadSavedMovies(userId: user.id)
        }
        
        .alert(
            "Deleted",
            isPresented: $viewModel.showDeleteSuccessAlert
        ) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.deleteSuccessMessage)
        }

    }
    
}


// Header Image
struct HeaderImageSection: View {
    @Environment(\.dismiss) private var dismiss
    let posterURL: String
    let title: String
    let movieId: String
    let isSaved: Bool
    var onSave: (() async -> Void)
    
    
    @State private var isCurrentlySaved: Bool

    init(posterURL: String, title: String, movieId: String, isSaved: Bool, onSave: @escaping (() async -> Void))  {
        self.posterURL = posterURL
        self.title = title
        self.movieId = movieId
        self.isSaved = isSaved
        self.onSave = onSave
        self._isCurrentlySaved = State(initialValue: isSaved)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: posterURL)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                        )
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 429)
            .clipped()
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .shadow(color: .black.opacity(0.7), radius: 10, x: 0, y: 0)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: shareText()) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.yellow)
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                                    if !isCurrentlySaved {
                                        Task {
                                            await onSave()
                                            isCurrentlySaved = true
                                        }
                                    }
                                }) {
                                    Image(systemName: isCurrentlySaved ? "bookmark.fill" : "bookmark")
                                        .foregroundColor(.yellow)
                                }
                                .disabled(isCurrentlySaved) // Disable if already saved
                            }
                        }
        .onChange(of: isSaved) { newValue in
            isCurrentlySaved = newValue
        }
    }
    
    private func shareText() -> String {
        return "Check out this movie: \(title)\n\(posterURL)"
    }
}


// Movie Info Grid
struct MovieInfoGrid: View {
    let duration: String
    let language: String
    let genre: String
    let age: String
    
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            InfoItemView(title: "Duration", value: duration)
            InfoItemView(title: "Language", value: language)
            InfoItemView(title: "Genre", value: genre)
            InfoItemView(title: "Age", value: age)
        }
        .padding(.horizontal, 20)
    }
}


struct InfoItemView: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.title3)
                .foregroundColor(.white)

            Text(value)
                .font(.body)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


// Story Section
struct StorySection: View {
    let story: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Story")
                .font(.title3)
                .foregroundColor(.white)

            Text(story)
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

// IMDb Rating
struct IMDBRatingSection: View {
    let rating: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("IMDb Rating")
                .font(.title3)
                .foregroundColor(.white)

            Text("\(String(format: "%.1f", rating)) / 10")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

// Director Section
struct DirectorSection: View {
    let directors: [Director]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Director")
                .font(.title3)
                .foregroundColor(.white)
            
            if directors.isEmpty {
                Text("No director information available")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.leading)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(directors) { director in
                            DirectorItemView(
                                name: director.fields.name,
                                imageURL: director.fields.image
                            )
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct DirectorItemView: View {
    let name: String
    let imageURL: String

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                .scaleEffect(0.7)
                        )
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                case .failure:
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 70, height: 70)

            Text(name)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 100)
    }
}

// Cast Section
struct CastSection: View {
    let actors: [Actor]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Stars")
                .font(.title3)
                .foregroundColor(.white)

            if actors.isEmpty {
                Text("No cast information available")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.leading)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(actors) { actor in
                            CastItemView(
                                name: actor.fields.name,
                                imageURL: actor.fields.image
                            )
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CastItemView: View {
    let name: String
    let imageURL: String

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                .scaleEffect(0.7)
                        )
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                case .failure:
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 70, height: 70)

            Text(name)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 100)
    }
}


// Review Button
struct WriteReviewButton: View {
    
    let movieId: String
    let user: AppUser

    var body: some View {
        NavigationLink {
            AddReviewView(movieId: movieId, user: user)
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "square.and.pencil")
                    .font(.body)

                Text("Write a review")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .foregroundColor(.yellow)
            .frame(maxWidth: .infinity)
            .frame(height: 30)
            .padding(.vertical, 14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.yellow, lineWidth: 1.5)
            )
            .padding(.horizontal, 16)
        }
    }
}


// Preview
#Preview {
    NavigationStack {
        // MoviesDetailsView(movieId: "reckJmZ458CZcLlUd")
    }
}
