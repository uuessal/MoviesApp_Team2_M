//
//  AddReview.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 09/07/1447 AH.
//

import SwiftUI

struct AddReviewView: View {

    @Environment(\.dismiss) var dismiss
    @State private var reviewText: String = ""
    @State private var rating: Int = 0

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    Text("Review")
                        .font(.title3)
                        .foregroundColor(.white)

                    ZStack(alignment: .topLeading) {
                        if reviewText.isEmpty {
                            Text("Enter your review")
                                .foregroundColor(.gray)
                                .padding(.top, 12)
                                .padding(.leading, 16)
                        }

                        TextEditor(text: $reviewText)
                            .foregroundColor(.white)
                            .padding(12)
                            .scrollContentBackground(.hidden)
                    }
                    .frame(height: 160)
                    .background(Color.white.opacity(0.12))
                    .cornerRadius(16)

                    // Rating
                    HStack {
                        Text("Rating")
                            .font(.title3)
                            .foregroundColor(.white)

                        Spacer()

                        HStack(spacing: 8) {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= rating ? "star.fill" : "star")
                                    .font(.title3)
                                    .foregroundColor(.yellow)
                                    .onTapGesture {
                                        rating = index
                                    }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Write a review")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {

            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.yellow)
                }
            }

            // Add Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddReviewView()
    }
}
