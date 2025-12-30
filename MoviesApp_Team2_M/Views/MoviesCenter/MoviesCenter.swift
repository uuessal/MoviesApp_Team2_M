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
    
    private var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return moviesList
        } else {
            return moviesList.filter { movie in
                movie.fields.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical){
            VStack (alignment: .leading ){
                
                
//high rated
                if (searchText.isEmpty) {
                    HighRated(moviesList: moviesList)
                    
                    Genre(moviesList: moviesList)}
                
                else{
                    Genre(moviesList: filteredMovies)

                    }
                    
                
                    
              
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



    #Preview {
        MoviesCenterView().preferredColorScheme(.dark)
    }
