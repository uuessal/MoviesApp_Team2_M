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
                    
                    
                    ForEach(ReviewsList , id: \.id) { Review in
                        
                        ReviewCardView(
                            userName: Review.fields.user_id, // قاعد يطلع الاي دي نحتاج نسوي نيتوركنق لابياي اليوزر عشان نسحب الاسم والصورة :)
                            review: Review.fields.review_text,
                            rate: Int(Review.fields.rate)
                            
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
