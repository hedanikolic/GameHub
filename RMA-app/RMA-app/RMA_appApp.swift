//
//  RMA_appApp.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI
import Firebase

@main
struct RMA_appApp: App {
    
    init() {
            FirebaseApp.configure()
        }
    
    @StateObject var userData = UserData()
    @StateObject var gameData = GameData()
    @StateObject var gameViewModel = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    
            }
            //.environment(\.colorScheme, .light)
            .environmentObject(gameData)
            .environmentObject(userData)
            .environmentObject(gameViewModel)
        }
    }
}
