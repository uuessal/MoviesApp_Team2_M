//
//  HighRated.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 30/12/2025.
//

import SwiftUI

struct HighRated : View {
    
    let moviesList : [Movie]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) { // spacing = 0 لإزالة الفراغ من فوق
            
            
            Text("High rated").font(Font.title).bold()
            //ScrollView(.horizontal){
            TabView{
                //  HStack (spacing : 30){
                
                
                ForEach(moviesList.sorted{ $0.fields.IMDb_rating/2 > $1.fields.IMDb_rating/2} .prefix(5), id: \.id) { Movie in
                    if (Movie.fields.IMDb_rating>=4.0){
                        NavigationLink(destination: MoviesDetailsView(movieId: Movie.id)) {
                            ZStack (alignment: .bottomLeading) {
                                AsyncImage(url: URL(string: Movie.fields.poster)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 366, height: 434)
                                        .clipped()
                                        .cornerRadius(5)
                                    
                                    
                                } placeholder: {
                                    
                                    
                                }
                                
                                VStack (alignment: .leading , spacing: 0.3){
                                    
                                    Text(Movie.fields.name).font(Font.title.bold()).foregroundColor(.white)
                                    
                                    HStack(spacing:0.4) {
                                        ForEach(0..<5) { star in
                                            if(star < Int(Movie.fields.IMDb_rating/2)){
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
                                    
                                    HStack {
                                        Text(String(format: "%.1f",Movie.fields.IMDb_rating/2)).font(Font.title2.bold()).foregroundColor(.white)
                                        Text("out of 5").foregroundColor(.white)
                                    }
                                    
                                    HStack (spacing: 0.4){
                                        ForEach(Movie.fields.genre, id: \.self) { genre in
                                            Text("\(genre)") }
                                        Text(".\(Movie.fields.runtime)")
                                    }
                                    
                                    
                                    
                                }.padding()
                                
                            }
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                }
                // }
            }.tabViewStyle(.page(indexDisplayMode: .always)).frame(height: 550)
        }
    }
}
