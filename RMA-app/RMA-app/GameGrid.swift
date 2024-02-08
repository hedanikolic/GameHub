//
//  GameGrid.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI
import UIKit

struct GameGrid: View {
    
    @Binding var game: Game
    @State private var isGridTapped = false
    @EnvironmentObject var userData: UserData

    let imageURL = URL(string: "https://e.snmc.io/lk/lv/x/eea8ccf5129cb92cab07d8fb363be933/8378753")!
    
    var loadedImage: UIImage? {
            loadImage(from: game)
        }
    
    var body: some View {
        Button(action: {
                       isGridTapped.toggle()
        }) {
            VStack{
                if let image = loadedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Text("Image Loading Failed")
                }
                
                HStack{
                    Text(game.gameName)
                        .frame(width: 100, height: 50)
                        .foregroundColor(.secondary)
                        .padding(.leading)
                    
                    Button(action: {game.isSaved.toggle()
                        if game.isSaved {
                            userData.savedGamesID.append(game.id)
                        }
                        else {
                            if let ind = userData.savedGamesID.firstIndex(of: game.id){
                                userData.savedGamesID.remove(at: ind)
                            }
                        }
                    }) {
                        if game.isSaved
                        {Image(systemName: "bookmark.fill")
                                .foregroundStyle(.pink)
                                .font(.title2)
                        } else {Image(systemName: "bookmark")
                                .foregroundStyle(.pink)
                                .font(.title2)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isGridTapped) {
                        GameDetailView(game: game)
                    }
    }
}


#Preview {
    GameGrid(game: Binding.constant(
        Game(gameName: "The Legend of Zelda: Breath of the Wild", imgURL: URL(string:"https://e.snmc.io/lk/lv/x/eea8ccf5129cb92cab07d8fb363be933/8378753")!, isSaved: true)
    ))
    .environmentObject(GameData())
}
