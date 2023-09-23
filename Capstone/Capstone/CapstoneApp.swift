//
//  CapstoneApp.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 23.07.2023.
//

import SwiftUI

@main
struct CapstoneApp: App {

    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    @State private var showLoginView: Bool = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().tintColor = UIColor(.theme.accent)
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                  HomeView().navigationBarHidden(true)
                }
                .environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView, showLoginView: $showLoginView)
                            .transition(.move(edge: .leading))
                    }
                    if showLoginView && !vm.userLoggedIn {
                        LoginView()
                            .transition(.move(edge: .trailing))
                            .environmentObject(vm)
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
