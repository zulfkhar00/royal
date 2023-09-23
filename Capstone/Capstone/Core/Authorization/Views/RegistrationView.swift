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
        vm.registerUser(name: name, email: email, password: password)
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
