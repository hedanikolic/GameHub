//
//  GameList.swift
//  RMA-app
//
//  Created by student on 01.02.2024..
//

import SwiftUI
import UIKit

struct GameList: View {
    
    @Binding var game: Game
    
    let imageURL = URL(string: "https://e.snmc.io/lk/lv/x/eea8ccf5129cb92cab07d8fb363be933/8378753")!
    
    var loadedImage: UIImage? {
            loadImage(from: game)
        }
    
    var body: some View {
        HStack{
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Text("Image Loading Failed")
            }
            
            HStack{
                Text(game.gameName)
                    .font(.title3)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                    .padding(.trailing)
                
                /*Image(systemName: "bookmark")
                 .foregroundStyle(.pink)
                 .font(.title2)*/
                /*Button(action: {game.isSaved.toggle()
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
                }*/
                Spacer()
                
                Button(action: {game.isSaved.toggle()}) {
                                if game.isSaved
                                {Image(systemName: "bookmark.fill")
                                        .foregroundStyle(.pink)
                                        .font(.title)
                                } else {Image(systemName: "bookmark")
                                        .foregroundStyle(.pink)
                                        .font(.title)
                                }
                            }

            }
        }
        .padding()
    }
}

#Preview {
    GameList(game: Binding.constant(
        Game(gameName: "The Legend of Zelda: Breath of the Wild", imgURL: URL(string:"https://e.snmc.io/lk/lv/x/eea8ccf5129cb92cab07d8fb363be933/8378753")!, isSaved: true)
    ))
    .environmentObject(GameData())
}
