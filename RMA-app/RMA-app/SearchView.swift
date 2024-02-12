//
//  SearchView.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var gameData: GameData
    @EnvironmentObject var levelData: LevelData
    
    @State var query = ""
    
    var foundGames: [Game]{
        if query.isEmpty{
            return gameData.games
        }
        else {
            let lowercaseQuery = query.lowercased()
            return gameData.games.filter {game in
                let lowercaseGameName = game.gameName.lowercased()
                return lowercaseGameName.contains(lowercaseQuery)
            }
        }
    }
    
    var body: some View {
        VStack{
            TextField("Search", text: $query)
                .frame(width: 300, height: 30)
                .border(.secondary)
                .multilineTextAlignment(.center)
                .padding()
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            List(Binding.constant(foundGames)){ game in
                GameList(game: game)
            }
            .listStyle(.plain)
            Spacer()
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(GameData())
        .environmentObject(LevelData())
}
