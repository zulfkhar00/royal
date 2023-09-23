//
//  LoginView.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 16/09/2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var signupPressed: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.theme.background.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.theme.background)
                loginView
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(dev.homeVM)
    }
}

extension LoginView {
    
    private var loginView: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .bold()
                .padding()
            
            TextField("Email", text: $email)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            
            TextField("Password", text: $password)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)

            Button("Sign in") {
                login()
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            
            
            NavigationLink(
                destination: RegistrationView().environmentObject(vm),
                isActive: $signupPressed,
                label: {
                    Button("Sign up") {
                        signupPressed.toggle()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(10)
                }
            )
            
        }
    }
    
    private func login() {
        vm.loginUser(email: email, password: password)
    }
    
}
