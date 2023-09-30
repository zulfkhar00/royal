//
//  RegistrationView.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 17/09/2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isArtist = false
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.theme.background.opacity(0.15))
            Circle()
                .scale(1.35)
                .foregroundColor(.theme.background)
            registerFormView
        }
    }
    
    private func register() {
        vm.registerUser(name: name, email: email, password: password, isArtist: isArtist)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(dev.homeVM)
    }
}

extension RegistrationView {
    
    private var registerFormView: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .bold()
                .padding()
            
            TextField("Name", text: $name)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            
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
            
            Toggle("I am an artist 🎵", isOn: $isArtist)
                .frame(width: 250, height: 50)
            
            Button("Sign up") {
                register()
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
        }
    }
    
}
