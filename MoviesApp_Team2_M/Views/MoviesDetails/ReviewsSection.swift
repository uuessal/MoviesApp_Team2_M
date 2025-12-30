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
                            review: Review.fields.review_text
                        )}
                        
                      
                    }
            }
        }
        .padding(.horizontal)
    }
}
