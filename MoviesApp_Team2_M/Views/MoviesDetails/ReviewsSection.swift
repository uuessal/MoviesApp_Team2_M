//
//  ReviewCard.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 30/12/2025.
//

import SwiftUI

// Reviews Section
struct ReviewsSection: View {
    let ReviewsList : [Review]
    let userList : [AppUser]
    let rating: Double

    
    @StateObject private var viewModel = ReviewViewModel()
    
    var usersById: [String: AppUser] {
        Dictionary(uniqueKeysWithValues: userList.map { ($0.id, $0) })
    }


    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Rating & Reviews")
                .font(.title3)
                .foregroundColor(.white)
            
            
            VStack(alignment: .leading, spacing: 2) {
                Text(String(rating/2))
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
                 
                    
                    ForEach(ReviewsList , id: \.id) { Review in
                        
                        let UserNameById = usersById[Review.fields.user_id]?.fields.name ?? "Unknown User"
                        let UserProfileById = usersById[Review.fields.user_id]?.fields.profile_image ?? "Unknown User"


                            ReviewCardView(
                                userName: UserNameById, // قاعد يطلع الاي دي نحتاج نسوي نيتوركنق لابياي اليوزر عشان نسحب الاسم والصورة :)
                                review: Review.fields.review_text,
                                rate: Int(Review.fields.rate),
                                ReviewDate: viewModel.simpleDay(from: Review.createdTime),
                                userProfile : UserProfileById
                            )}
                        
                      
                    }
            }
        }
        .padding(.horizontal)
    }
}




struct ReviewCardView: View {
    let userName: String
    let review: String
    let rate : Int
    let ReviewDate : String
    let userProfile :String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Header (Avatar + Name + Stars)
            HStack(alignment: .top, spacing: 12) {
                // Avatar
                AsyncImage(url: URL(string: userProfile)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 36, height: 36)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 6) {
                    Text(userName)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    HStack(spacing: 4) {
                        ForEach(0..<5) { star in
                            if(star < rate){
                                Image(systemName: "star.fill")
                                    .font(.caption2)
                                    .foregroundColor(.yellow)
                            }
                            else{
                                Image(systemName: "star")
                                    .font(.caption2)
                                    .foregroundColor(.yellow)
                            }}
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
                Text(ReviewDate)
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
