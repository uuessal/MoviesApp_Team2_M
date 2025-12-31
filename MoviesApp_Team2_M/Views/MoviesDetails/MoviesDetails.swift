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
    let movieId: String
    
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

                    HeaderImageSection(posterURL: movie.fields.poster)

                    MovieTitleSection(title: movie.fields.name)

                    MovieInfoGrid(
                        duration: movie.fields.runtime,
                        language: movie.fields.language.joined(separator: ", "),
                        genre: movie.fields.genre.joined(separator: ", "),
                        age: movie.fields.rating
                    )

                    StorySection(story: movie.fields.story)

                    IMDBRatingSection(rating: movie.fields.IMDb_rating)

                    DirectorSection(directors: viewModel.directors)

                    CastSection()

                    ReviewsSection(ReviewsList: viewModel.reviewsList)
                    
                    WriteReviewButton()
                }
                .padding(.bottom, 32)
            } else if let errorMessage = viewModel.errorMessage {
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
        }
    }
}


// Header Image
struct HeaderImageSection: View {
    @Environment(\.dismiss) private var dismiss
    let posterURL: String

    var body: some View {
        ZStack {
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
            .frame(height: 320)
            .clipped()
        }
        .toolbar {
            // Back Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.yellow)
                }
            }

            // Share Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.yellow)
                }
            }

            // Bookmark Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "bookmark")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}



// Movie Title
struct MovieTitleSection: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal)
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
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Stars")
                .font(.title3)
                .foregroundColor(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    CastItemView(name: "Tim Robbins")
                    CastItemView(name: "Morgan")
                    CastItemView(name: "Bob Gunton")
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CastItemView: View {
    let name: String

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 70, height: 70)

            Text(name)
                .font(.body)
                .foregroundColor(.gray)
        }
        .frame(width: 100)
    }
}


// Reviews Section
// حطيته بملف لحال


struct ReviewCardView: View {
    let userName: String
    let review: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Header (Avatar + Name + Stars)
            HStack(alignment: .top, spacing: 12) {
                // Avatar
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: 6) {
                    Text(userName)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    HStack(spacing: 4) {
                        ForEach(0..<3) { _ in
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(.yellow)
                        }
                        ForEach(0..<2) { _ in
                            Image(systemName: "star")
                                .font(.caption)
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }

            // Review text
            Text(review)
                .font(.body)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)

            // Date
            HStack {
                Spacer()
                Text("Tuesday")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .frame(width: 300)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.08))
        )
    }
}

// Review Button
struct WriteReviewButton: View {
    var body: some View {
        NavigationLink {
           AddReviewView()
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
        MoviesDetailsView(movieId: "reckJmZ458CZcLlUd")
    }
}
