//
//  Genre.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 30/12/2025.
//


import SwiftUI

struct Genre : View {
    
    let moviesList : [Movie]
    
    
    
    var allGenres: [String] {
        Array(Set(moviesList.flatMap { $0.fields.genre }))
    }
    
    var body: some View {
        
        ForEach(allGenres, id: \.self) { genre in
            
            
            HStack{
                
                
                
                Text(genre).font(Font.title2).bold()
                Spacer()
                Text("Show more").foregroundColor(.yellow)
                
            }.padding()
            
            
            
            
            
            
            
            ScrollView(.horizontal){
                HStack{
                    
                    
                    ForEach(moviesList , id: \.id) { Movie in
                        
                        if (Movie.fields.genre.contains(genre)){
                            
                            AsyncImage(url: URL(string: Movie.fields.poster)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 208, height: 275)
                                    .clipped()
                                    .cornerRadius(10)
                                
                            } placeholder: {
                                
                            }
                            
                        }
                    }
                    
                    
                    
                    
                }
                
            }
            
            
            
            
            
            
        }
        
        
    }
            
            
        }
    
