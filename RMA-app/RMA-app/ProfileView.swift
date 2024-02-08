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
            
            HStack{
                Image(userData.imageName)
                    .resizable()
                    .frame(width: 55, height: 55)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                Text(userData.username)
                    .font(.title2)
                    .foregroundStyle(.pink)
                    .padding()
            }
            .padding()
            /*Text("My Tweets")
             List(Binding.constant(gameData.getGames( inds:
             userData.savedGamesID))){ game in
             GameGrid(game: game)
             }
             .listStyle(.plain)
             .padding()*/
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
}
