//
//  ReviewsAPI.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 30/12/2025.
//

//
//  movies.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 03/07/1447 AH.
//

import Foundation


func fetchReviewsFromAPI() async throws -> [Review] {
    let data = try await APIClient.fetch("/reviews?filterByFormula=%7Bmovie_id%7D%3D%22reca1oIIcB4R3HVgw%22")
    // الفلم ثابت حاليا المفروض نمرر ايدي الفلم هنا
    let decoded = try JSONDecoder().decode(ReviewsResponse.self, from: data)
    return decoded.records
}


