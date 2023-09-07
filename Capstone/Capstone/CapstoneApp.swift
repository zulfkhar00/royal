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

    var body: some Scene {
        WindowGroup {
          NavigationView {
            HomeView().navigationBarHidden(true)
          }
          .environmentObject(vm)
        }
    }
}
