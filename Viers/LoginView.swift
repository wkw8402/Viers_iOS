//
//  LoginView.swift
//  Viers
//
//  Created by Kun  on 14/12/22.
//


import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Log In") {
                    viewModel.login(email: email, password: password)
                }
                .buttonStyle(LoginButton())
                
                .padding()
                
                Button("Sign Up") {
                    viewModel.register(email: email, password: password)
                }
                .buttonStyle(SignUpButton())
            }
            .navigationTitle("Get Started!")
        }
    }
}

struct SignUpButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(UIColor(red: 2/225, green: 169/255, blue:247/255, alpha: 1.0)))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct LoginButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(UIColor(red: 2/225, green: 169/255, blue:247/255, alpha: 1.0)))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
