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



    #Preview {
        MoviesCenterView().preferredColorScheme(.dark)
    }
