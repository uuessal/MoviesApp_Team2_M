//
//   movie.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash on 03/07/1447 AH.
//

import Foundation


// Decodable لاننا بس نحتاج ال نحدده

struct Movie: Decodable {
    
    
    let id: String
    let name : String
    let poster : String
    let story: String
    let runtime: String
    let genre: [String]
    let rating : String
    let IMDb_rating : Double
    let language : [String]
}


struct MoviessResponse {
let results: [Movie]
}

struct mockData {
    static  let FakeDramamovie = Movie(id: "2", name: "Movie1 name ", poster: "https://upload.wikimedia.org/wikipedia/en/e/e2/Causeway_%28film%29.jpg", story: "Movie story", runtime: "2h 40m ", genre: ["drama"], rating: "rating", IMDb_rating: 4.5, language: ["arabic","eng"])
    
    static  let FakeComedymovie = Movie(id: "3", name: "Movie2 name ", poster: "https://m.media-amazon.com/images/I/91zWyEDrjNL._AC_UF1000,1000_QL80_.jpg", story: "Movie story", runtime: "1h 30m ", genre: ["comedy"], rating: "rating", IMDb_rating: 4.3, language: ["arabic","eng"])
    
    static let FakemoviesList = [FakeComedymovie,FakeDramamovie,FakeComedymovie,FakeDramamovie]
}
