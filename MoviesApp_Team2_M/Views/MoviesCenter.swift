//
//  MoviesCenter.swift
//  MoviesApp_Team2_M
//
//  Created by wessal hashim alharbi on 24/12/2025.
//

import SwiftUI

struct MoviesCenterView: View {
    
    @State private var searchText: String = ""
    var body: some View {
        
        NavigationStack {
            
            ScrollView(.vertical){
            VStack (alignment: .leading ){
                
                
//high rated
                
                Text("High rated").font(Font.title).bold()
                ScrollView(.horizontal){
                    HStack (spacing : 30){
                        
                        
                        ForEach(mockData.FakemoviesList , id: \.id) { Movie in
                            ZStack (alignment: .bottomLeading) {
                                AsyncImage(url: URL(string: Movie.poster)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()                                          .frame(width: 366, height: 434)
                                        .clipped() 
                                        .cornerRadius(5)
                                    
                                    
                                } placeholder: {
                                    
                                    
                                }
                                
                                VStack (alignment: .leading , spacing: 0.3){
                                    
                                    Text(Movie.name).font(Font.title.bold()).foregroundColor(.white)
                                    
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
                                        Text(String(format: "%.1f",Movie.IMDb_rating)).font(Font.title2.bold()).foregroundColor(.white)
                                        Text("out of 5").foregroundColor(.white)
                                    }
                                    
                                    HStack (spacing: 0.4){
                                        ForEach(Movie.genre, id: \.self) { genre in
                                            Text("\(genre)") }
                                        Text(".\(Movie.runtime)")
                                    }
                                    
                                    
                                    
                                }.padding()
                                
                                
                            }}
                        
                        
                        
                        
                        //  width: 366 , height: 434  حجمه بفيقما
                        Rectangle().fill(Color.blue)
                            .frame(width: 366 , height: 434)
                    }
                    
                }
                    
//genre
                
                //drama
                     
                
                HStack{
                  Text("Drama").font(Font.title2).bold()
                  Spacer()
                    Text("Show more").foregroundColor(.yellow)
                
                }
              ScrollView(.horizontal){
                  HStack{
                      
                      
                      ForEach(mockData.FakemoviesList , id: \.id) { Movie in
                          
                          if (Movie.genre.contains("drama")){
                              
                              AsyncImage(url: URL(string: Movie.poster)) { image in
                                  image
                                      .resizable()
                                      .scaledToFit().cornerRadius(5).frame(width: 208, height: 275)
                              } placeholder: {

                              }
                              
                          }
                      }
                   
                      
                      
                      
                  }}
                
                //comedy
                
                    HStack{
                        Text("Comedy").font(Font.title2).bold()
                        Spacer()
                        Text("Show more").foregroundColor(.yellow) }
                    
                    ScrollView(.horizontal){
                        HStack{
                            
                            ForEach (mockData.FakemoviesList , id: \.id) { Movie in
                                
                                if (Movie.genre .contains("comedy")){
                                    
                                    AsyncImage(url: URL(string: Movie.poster)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit().cornerRadius(5).frame(width: 208, height: 275)
                                    } placeholder: {
                                        //  ProgressView() // لودينق
                                    }
                                    
                                }
                            }
                           
                            
                            
                            
                        }}
                    
                    
                    
                 
Spacer()
                    
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                    .navigationTitle("Movie Center")
                    .searchable(text:$searchText,placement: .navigationBarDrawer, prompt: "Serach Movie")
                
                
                
                
            } .padding(.horizontal)
        }
    }}



#Preview {
    MoviesCenterView().preferredColorScheme(.dark)
}
