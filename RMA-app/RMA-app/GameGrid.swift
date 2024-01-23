//
//  GameGrid.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

struct GameGrid: View {
    
    @Binding var game: Game
     @EnvironmentObject var gameData: GameData
    
    var body: some View {
        VStack{
            Image("DiabloIV")
            
            Text(game.gameName)
        }
    }
}

#Preview {
    GameGrid(game: Binding.constant(
        Game(gameName: "Diablo IV")
    )
    .environmentObject(GameData())
             )
}
