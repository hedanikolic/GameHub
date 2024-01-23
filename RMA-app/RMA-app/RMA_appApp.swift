//
//  RMA_appApp.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

@main
struct RMA_appApp: App {
    
    @StateObject var userData = UserData()
    
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
        }
    }
}
