//
//  Profile.swift
//  sing in
//
//  Created by Shahd Muharrq on 07/07/1447 AH.
//

import SwiftUI

struct Profilepage: View {
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading,spacing: 40){
                ProfileButton()
                
                Text("Saved Movies")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                
                
                Spacer().frame(height: 100)
            }
            
            
            VStack(alignment: .center){
                Image("Empty state content")
                
                Text("No saved movies yet,\n start save your favourites")
                    .foregroundColor(.gray)
//
            }
            Spacer()
            
                .navigationTitle("Profile")
            
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Image(systemName: "chevron.left")
                        .foregroundColor(.yellow)}
                    
                    
                }.preferredColorScheme(.dark)
            
        }
        
        
    }
    
    
    
    struct ProfileButton: View {
        var body: some View {
            Button(action: {}) {
                HStack(spacing: 12) {
                    
                    Image("ProfileIcon")
                        .resizable()
                        .frame(width: 56, height: 56)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Sarah Abdullah")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("xxx234@gmail.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .tint(.gray)
                    }
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                
            }
            .frame(width: 358, height: 80)
            .padding(.horizontal, 16)
            .background(Color.gray.opacity(0.26))
            .cornerRadius(8)
            .buttonStyle(.plain)
            
        }
        
    }
}
#Preview {
    Profilepage()
}

