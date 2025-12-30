//
//  MoviesCenter.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 24/12/2025.
//

import SwiftUI




struct MoviesCenterView: View {
  
    @State var moviesList: [Movie] = []

    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical){
            VStack (alignment: .leading ){
                
                
//high rated
                                    
                    HighRated(moviesList: moviesList)
                    
                
//genre
                
                
                  Genre(moviesList: moviesList)
                    
                    
                 
Spacer()
                    
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                    .navigationTitle("Movie Center")
                    .searchable(text:$searchText,placement: .navigationBarDrawer, prompt: "Serach Movie")
                
                
                
                
            } .padding(.horizontal)
                .task {
                do {
                     moviesList = try await fetchMoviesFromAPI()
            
                    print(moviesList)
                } catch {
                    print(error)
                }
            }

        }
    }}



struct HighRated : View {
    
    let moviesList : [Movie]
    
    var body: some View {
        
        
        Text("High rated").font(Font.title).bold()
        ScrollView(.horizontal){
            HStack (spacing : 30){
                
                
                ForEach(moviesList.sorted{ $0.fields.IMDb_rating/2 > $1.fields.IMDb_rating/2} .prefix(5), id: \.id) { Movie in
                    if (Movie.fields.IMDb_rating>=4.0){
                        ZStack (alignment: .bottomLeading) {
                            AsyncImage(url: URL(string: Movie.fields.poster)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()                                          .frame(width: 366, height: 434)
                                    .clipped()
                                    .cornerRadius(5)
                                
                                
                            } placeholder: {
                                
                                
                            }
                            
                            VStack (alignment: .leading , spacing: 0.3){
                                
                                Text(Movie.fields.name).font(Font.title.bold()).foregroundColor(.white)
                                
                                HStack(spacing:0.4) {
                                    ForEach(0..<4) { _ in
                                        Image(systemName: "star.fill")
                                            .font(.caption2)
                                            .foregroundColor(.yellow)
                                    }
                                    
                                    Image(systemName: "star")
                                        .font(.caption2)
                                        .foregroundColor(.yellow)
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
                            
                        }}}}
                
       
            }
            
        }
    }




     

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
    
    #Preview {
        MoviesCenterView().preferredColorScheme(.dark)
    }
