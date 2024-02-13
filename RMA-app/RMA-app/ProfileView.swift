//
//  ProfileView.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var gameData: GameData
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var levelData: LevelData
    @State var username: String = ""
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "gamecontroller.fill")
                    .foregroundStyle(.pink)
                    .font(.title)
                Text("Game Guide")
                    .font(.title)
                    .foregroundStyle(.pink)
                Spacer()
            }
            .padding()
            
            VStack{
                Image(systemName: "person.crop.artframe")
                    .resizable()
                    .frame(width: 60, height: 70)
                    .foregroundStyle(.secondary)
                    //.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                Text(userData.username)
                    .font(.title)
                    .foregroundStyle(.pink)
                    //.padding()
            }
            .padding(.vertical, 30)
            
            HStack{
                Text("Saved Games")
                    .font(.title2)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                    .padding()
                Spacer()
            }
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 0),
                    GridItem(.flexible(), spacing: 0)
                ], spacing: 30) {
                    ForEach(gameData.getGames(inds: userData.savedGamesID)) { game in
                        GameGrid(game: .constant(game))
                    }
                }
                .padding()
                
                
                Spacer()
                
                
            }
        }
    }
}
        
#Preview {
    ProfileView()
        .environmentObject(GameData())
        .environmentObject(UserData())
        .environmentObject(LevelData())
}
