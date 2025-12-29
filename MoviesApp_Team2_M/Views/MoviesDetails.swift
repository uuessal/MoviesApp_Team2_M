//
//  MoviesDetails.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 04/07/1447 AH.
//

import SwiftUI

// Main View
struct MoviesDetailsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                HeaderImageSection()

                MovieTitleSection()

                MovieInfoGrid()

                StorySection()

                IMDBRatingSection()

                DirectorSection()

                CastSection()

                ReviewsSection()
                
                WriteReviewButton()
            }
            .padding(.bottom, 32)
        }
        .background(Color.black)
        .ignoresSafeArea(edges: .top)
    }
}



// Header Image
struct HeaderImageSection: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Image("movie_placeholder")
                .resizable()
                .scaledToFill()
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
    var body: some View {
        Text("Shawshank")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal)
    }
}

// Movie Info Grid
struct MovieInfoGrid: View {
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            InfoItemView(title: "Duration", value: "2 hours 22 mins")
            InfoItemView(title: "Language", value: "English")
            InfoItemView(title: "Genre", value: "Drama")
            InfoItemView(title: "Age", value: "+15")
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
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Story")
                .font(.title3)
                .foregroundColor(.white)

            Text("Synopsis. In 1947, Andy Dufresne is convicted of murder and sent to Shawshank prison, where he forms a friendship and finds hope.")
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

// IMDb Rating
struct IMDBRatingSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("IMDb Rating")
                .font(.title3)
                .foregroundColor(.white)

            Text("9.3 / 10")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

// Director Section
struct DirectorSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Director")
                .font(.title3)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    DirectorItemView(name: "Tim Robbins")
                }
            }
            
        }
        .padding(.horizontal)
    }
}


struct DirectorItemView: View {
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
struct ReviewsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Rating & Reviews")
                .font(.title3)
                .foregroundColor(.white)
            
            
            VStack(alignment: .leading, spacing: 2) {
                Text("4.8")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("out of 5")
                    .font(.body)
                //.fontWeight(.bold)
                .foregroundColor(.gray)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ReviewCardView(
                        userName: "Afnan Abdullah",
                        review: "This is an engagingly simple, good-hearted film with contrast and relief."
                    )

                    ReviewCardView(
                        userName: "User Name",
                        review: "A powerful story about hope and friendship."
                    )
                }
            }
        }
        .padding(.horizontal)
    }
}

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
        MoviesDetailsView()
    }
}
