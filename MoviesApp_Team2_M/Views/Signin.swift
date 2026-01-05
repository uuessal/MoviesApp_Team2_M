//
//  Signin.swift
//  MoviesApp_Team2_M
//
//  Created by Shahd Muharrq on 07/07/1447 AH.
//

import SwiftUI

struct SigninPage: View {
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
    @StateObject private var viewModel = SigninViewModel()
    var body: some View{
        VStack (alignment: .leading)
        {
            Spacer()
            
            Text("Sign in")
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
                    text: $viewModel.email,
                    isSecure: false
                )
                
                DesignInputField(
                    title: "Password",
                    placeholder: "1234567@@",
                    text: $viewModel.password,
                    isSecure: true
                )
                
            }
            
            
            if let error = viewModel.errorMessage {
                           Text(error)
                               .foregroundColor(.red)
                       }
            Spacer().frame(height: 41)
            SigninButton(viewModel: viewModel)
            
        }
    }
}


struct DesignInputField: View {
    let title: String
    
    let placeholder: String
    
    @Binding var text: String
    
    let isSecure: Bool
    
    @State private var showPassword = false

    var body: some View {
        VStack(alignment:.leading){
            Text(title)
                .foregroundStyle(.white)
                .font(.headline)
                .padding(.bottom ,2)
            
            ZStack(alignment: .trailing){
                
                Group{
                    if isSecure && !showPassword  {
                        SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray))
                    } else {
                        TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray))
                        
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.26))
                .frame(width: 358, height: 44)
                .cornerRadius(8)
                .foregroundColor(.white)
                .accentColor(.yellow)
                
                
                if isSecure {
                    
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                            .padding(.trailing, 12)
                        
                    }
                }
            }
                        
        }
        
    }
    
    
}



struct SigninButton: View {
    @ObservedObject var viewModel: SigninViewModel
    @State private var navigate = false

    var body: some View {
        VStack {
            Button {
                Task {
                    await viewModel.signIn()
                    if viewModel.user != nil {
                        print("✅ Navigation triggered - User: \(viewModel.user?.fields.name ?? "Unknown")")
                        navigate = true
                    } else {
                        print("❌ Navigation blocked - No user logged in")
                    }
                }
            } label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(width: 358, height: 44)
                    .background(Color.yellow)
                    .cornerRadius(8)
            }

            // Navigate to MoviesCenterView with the logged-in user's ID
            if let user = viewModel.user {
                NavigationLink(
                    destination: MoviesCenterView(user: user),
                    isActive: $navigate
                ) {
                    EmptyView()
                }
            }
        }
    }
}



#Preview {
    SigninPage()
}
