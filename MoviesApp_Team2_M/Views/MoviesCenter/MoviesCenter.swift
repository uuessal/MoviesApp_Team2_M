//
//  MoviesCenter.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 24/12/2025.
//

import SwiftUI

struct MoviesCenterView: View {
    
    @StateObject private var viewModel = MoviesCenterViewModel()
    let user: AppUser
    
    //testing
    
  //  user = AppUser(id: "recPMaNVKM6yYZFIl", fields: UserFields())
    
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
                        HighRated(moviesList: moviesList , user : user)
                        
                        Genre(moviesList: moviesList , user : user)
                        
                    }
                    else{
                        Genre(moviesList: filteredMovies , user : user)
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .navigationTitle("Movie Center")
                .navigationBarBackButtonHidden(true)
                .searchable(text:$searchText, placement: .navigationBarDrawer, prompt: "Search Movie")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: Profilepage(user : user)) {
                            AsyncImage(url: URL(string: user.fields.profile_image)) { image in
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
            }
            .padding(.horizontal)
            .background(Color.black)
            .task {
                do {
                    moviesList = try await fetchMoviesFromAPI()
                    print(moviesList)
                } catch {
                    print(error)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
   // MoviesCenterView(userId: "recaLvl1OOPjSagCx")
}
