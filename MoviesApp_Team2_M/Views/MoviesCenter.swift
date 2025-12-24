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
            
            
            
            //محتوى الصفحة هنا
            
            
            ScrollView(.vertical){
                VStack (alignment: .leading){
                    
                    Text("High rated").font(Font.title).bold()
                    
                    
                    
                    ScrollView(.horizontal){
                        
                        HStack{
                            
                            
                            Rectangle().fill(Color.blue)
                                .frame(width: 366 , height: 434)
                            
                            //  width: 366 , height: 434  حجمه بفيقما
                            
                            Rectangle().fill(Color.blue)
                                .frame(width: 366 , height: 434)
                            
                            
                        }}
                    
                    HStack{
                        Text("Drama").font(Font.headline).bold()
                        Spacer()
                        Text("Show more")
                        
                        
                    }
                    
                    
                    ScrollView(.horizontal){
                        HStack{
                            
                            
                            Rectangle().fill(Color.blue)
                                .frame(width: 208 , height: 275)
                            Rectangle().fill(Color.blue)
                                .frame(width: 208 , height: 275)
                            Rectangle().fill(Color.blue)
                                .frame(width: 208 , height: 275)
                            //  width: 208 , height: 275  حجمه بفيقما
                            
                            
                            
                        }}
                    
                    HStack{
                        Text("Comedy").font(Font.headline).bold()
                        Spacer()
                        Text("Show more")
                        
                        
                    }
                    
                    
                    ScrollView(.horizontal){
                        HStack{
                            
                            
                            Rectangle().fill(Color.blue)
                                .frame(width: 208 , height: 275)
                            Rectangle().fill(Color.blue)
                                .frame(width: 208 , height: 275)
                            Rectangle().fill(Color.blue)
                                .frame(width: 208 , height: 275)
                            //  width: 208 , height: 275  حجمه بفيقما
                            
                            
                            
                        }}
                    
                    
                    
                    Spacer()
                    
                    
                    
                    
                    
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                
                
                
                
                
                
                
                
                
                    .navigationTitle("Movie Center")
                    .searchable(text:$searchText,placement: .navigationBarDrawer, prompt: "Serach Movie")
                
                
            } .padding(.horizontal)
        }
    }}

#Preview {
    MoviesCenterView()
}
