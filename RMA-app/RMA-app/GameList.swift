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
    @State private var isGridTapped = false
    @State private var loadedImage: UIImage?
    @EnvironmentObject var userData: UserData

    var body: some View {
        Button(action: {
            isGridTapped.toggle()
        }) {
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
                    
                    Spacer()
                    
                    Button(action: {
                        game.isSaved.toggle() // Toggle isSaved property
                    }) {
                        if game.isSaved {
                            Image(systemName: "bookmark.fill")
                                .foregroundStyle(.pink)
                                .font(.title)
                        } else {
                            Image(systemName: "bookmark")
                                .foregroundStyle(.pink)
                                .font(.title)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isGridTapped) {
            GameDetailView(game: $game)
                .environmentObject(LevelData())
        }
        .padding()
        .onAppear {
            loadImageAsync(from: game.imgURL) { image in
                self.loadedImage = image
            }
        }
    }
}

#Preview {
    GameList(game: Binding.constant(
        Game(gameName: "The Legend of Zelda: Breath of the Wild", imgURL: URL(string:"https://e.snmc.io/lk/lv/x/eea8ccf5129cb92cab07d8fb363be933/8378753")!, isSaved: true)
    ))
    .environmentObject(GameData())
    .environmentObject(LevelData())
}
