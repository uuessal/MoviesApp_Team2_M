//
//  MoviesCenter.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 24/12/2025.
//

import SwiftUI




struct MoviesCenterView: View {
    
    
    @StateObject private var viewModel = MoviesCenterViewModel()
    let userId: String  // Pass user ID when navigating to this page

    
    
    
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
                VStack (alignment: .leading , spacing: 10 ){
                    
                    
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
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: Profilepage(userId: userId )) {
                                
                                AsyncImage(url: URL(string: "https://i.pinimg.com/736x/00/47/00/004700cb81873e839ceaadf9f3c1fb28.jpg")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                }
                                .frame(width: 36, height: 36)
                                .clipShape(Circle())
                                
                            }
                        }
                    }
                        
                        
                        
                        
                        
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
        MoviesCenterView(userId: "recaLvl1OOPjSagCx").preferredColorScheme(.dark)
    }

