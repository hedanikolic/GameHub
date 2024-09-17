//
//  ContentView.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

struct ContentView: View {
    
    //@State var content: String = ""
    @State var isPresented: Bool = false
    //@State var username: String = ""
    
    @EnvironmentObject var gameData: GameData
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var levelData: LevelData
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "gamecontroller.fill")
                    .foregroundStyle(Color.pink.opacity(0.8))
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Game Guide")
                    .font(.title)
                    .foregroundStyle(Color.pink.opacity(0.8))
                Spacer()
                if userData.username.isEmpty{
                    Button(action: {isPresented = true}){
                        Text("Log in")
                            .foregroundStyle(Color.pink.opacity(0.8))
                    }
                } else{
                    Button(action: {userData.username = ""}){
                        Text("Log out")
                            .foregroundStyle(Color.pink.opacity(0.8))
                    }
                }
            }
            .padding()
            Text("Stuck on a level? Find the answer here!")
                .padding(.vertical, 20)
                .font(.title2)
                .foregroundColor(.primary)
            
            HStack{
                Text("Browse popular games")
                    .padding(.bottom)
                    .padding(.leading)
                    .font(.title3)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 0),
                    GridItem(.flexible(), spacing: 0)
                ], spacing: 30) {
                    ForEach($gameData.games) { game in
                        GameGrid(game: game)
                    }
                }
                .listStyle(.plain)
                
            }
            
            Spacer()
            Text("or search for the game by name")
                .padding(.vertical)
                .multilineTextAlignment(.center)
                .font(.title3)
                .foregroundColor(.primary)
        }
        .sheet(isPresented: $isPresented) {
            LoginView(username: $userData.username, isPresented: $isPresented)}
        
    }
}


#Preview {
    ContentView()
        .environmentObject(GameData())
        .environmentObject(UserData())
        .environmentObject(LevelData())
}
