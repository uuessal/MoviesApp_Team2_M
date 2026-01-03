//
//  Signin.swift
//  MoviesApp_Team2_M
//
//  Created by Shahd Muharrq on 07/07/1447 AH.
//


//
//  ContentView.swift
//  sing in
//
//  Created by Shahd Muharrq on 04/07/1447 AH.
//

import SwiftUI

struct SigninPage: View {
    
    let userId: String  // Pass user ID when navigating to this page

    var body: some View {
        
        
        ZStack {
           
            Image("Sinbackground")
                .resizable()
                .ignoresSafeArea()
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(1.1),   Color.black.opacity(0)]),
                startPoint: .bottom,
                endPoint: .top).ignoresSafeArea()
            
            InputField()
        }
    }
    
    
}


struct InputField: View {
    var body: some View{
        VStack (alignment: .leading)
    {
            Spacer()
            
            Text("Sing in")
                .font(.largeTitle.bold())
                .foregroundStyle(Color.white)
        Spacer().frame(height: 8)
        Text("You'll find what you're looking for in the ocean of movies")
            .foregroundStyle(Color.white)
            .font(
                    .system(
                        size: 18,
                        weight: .medium,
                        design: .default
                    )
                    )
        Spacer().frame(height: 41)
        VStack (spacing:20){
            
             DesignInputField(
                title: "Email",
                placeholder: "youremail@gmail.com",
                isSecure: true,
                
            )
            
            DesignInputField(
                title: "Password",
                placeholder: "4444",
                isSecure: true,
                
            )
            
        }
        Spacer().frame(height: 41)
        SigninButton()
        }
       

    }
}


struct DesignInputField: View {
    let title: String
    /*انا هنا ضفت اللت في الكود عشان الديزاين الي فوق يستقبل معلومات  ويشتغل  */
    let placeholder: String
    let isSecure: Bool
    var body: some View {
        VStack(alignment:.leading){
            Text(title)
                .foregroundStyle(.white)
                .font(.headline)
                .padding(.bottom ,2)
            
            ZStack(alignment: .trailing){
                
                Group{
                    if isSecure {
                        SecureField("", text: .constant(placeholder))
                    } else {
                        TextField("", text: .constant(placeholder))
                        
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.26))
                .frame(width: 358, height: 44)
                .cornerRadius(8)
                .foregroundColor(.white)
                .accentColor(.yellow)
               
                
                if isSecure {
                  Image(systemName: "eye.slash")
                        .foregroundColor(.gray)
                        .padding(.trailing, 12)
                    
                }
            }
            
            
            
            
        }
        
    }
    
    
            }
            
            
        
struct SigninButton: View {
    var body: some View {
        
        NavigationLink(destination: MoviesCenterView(userId : "recaLvl1OOPjSagCx" )) {
            Text("Sing in")
                .font(.headline)
                .foregroundColor(.black)
                .frame(width: 358, height: 44)
                .background(Color.yellow)
                .cornerRadius(8)
            
        }
    }
}
        
        
#Preview {
    NavigationStack {
        SigninPage(userId: "recaLvl1OOPjSagCx")
    }
}
    
