//
//  ContentView.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

struct ContentView: View {
    
    @State var content: String = ""
    @State var isPresented: Bool = false
    @State var username: String = ""
    
    @EnvironmentObject var gameData: GameData
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var levelData: LevelData
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "gamecontroller.fill")
                    .foregroundStyle(.pink)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Game Guide")
                    .font(.title)
                    .foregroundStyle(.pink)
                Spacer()
                if username.isEmpty{
                    Button(action: {isPresented = true}){
                        Text("Log in")
                            .foregroundStyle(.red)
                    }
                } else{
                    Button(action: {username = ""}){
                        Text("Log out")
                            .foregroundStyle(.red)
                    }
                }
            }
            .padding()
            Text("Stuck on a level? Find the answer here!")
                .padding(.vertical, 50)
                .font(.title2)
                .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
            
            HStack{
                Text("Browse popular games")
                    .padding(.bottom)
                    .padding(.leading)
                    .font(.title3)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                
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
                .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
        }
        .sheet(isPresented: $isPresented) {
            LoginView(username: $username, isPresented: $isPresented)}
    }
}


#Preview {
    ContentView()
        .environmentObject(GameData())
        .environmentObject(UserData())
        .environmentObject(LevelData())
}
