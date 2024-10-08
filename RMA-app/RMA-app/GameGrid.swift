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
    //@EnvironmentObject var levelData: LevelData
    @State private var loadedImage: UIImage?
    @StateObject var gameViewModel = GameViewModel()


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
                    
                    
                    //Firebase
                    Button(action: {
                        print("Bookmark button tapped")
                        guard !userData.username.isEmpty else {
                                print("No user logged in")
                                return
                            }

                        game.isSaved.toggle()
                        if game.isSaved {
                            gameViewModel.bookmarkGame(gameID: game.id, gameName: game.gameName, forUser: userData.username)
                            userData.savedGamesID.append(game.id)
                        } else {
                            gameViewModel.removeBookmarkedGame(gameID: game.id, forUser: userData.username)
                            if let ind = userData.savedGamesID.firstIndex(of: game.id) {
                                userData.savedGamesID.remove(at: ind)
                            }
                        }
                    }) {
                        if game.isSaved && !userData.username.isEmpty
                                                {Image(systemName: "bookmark.fill")
                                                        .foregroundStyle(Color.pink.opacity(0.8))
                                                        .font(.title2)
                                                } else {Image(systemName: "bookmark")
                                                        .foregroundStyle(Color.pink.opacity(0.8))
                                                        .font(.title2)
                                                }
                                            }
                    }

                    
                    
                    
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
                                .foregroundStyle(Color.pink.opacity(0.8))
                                .font(.title2)
                        } else {Image(systemName: "bookmark")
                                .foregroundStyle(Color.pink.opacity(0.8))
                                .font(.title2)
                        }
                    }*/
                }
            }
        
        .sheet(isPresented: $isGridTapped) {
            GameDetailView(game: $game)
                .environmentObject(LevelData())
        }
        .onAppear(perform: {
            loadImageAsync(from: self.game.imgURL) { image in
                        self.loadedImage = image
                    }
                })
    }
}


#Preview {
    GameGrid(game: Binding.constant(
        Game(gameName: "The Legend of Zelda: Breath of the Wild", imgURL: URL(string:"https://e.snmc.io/lk/lv/x/eea8ccf5129cb92cab07d8fb363be933/8378753")!, isSaved: true)
    ))
    .environmentObject(GameData())
    .environmentObject(LevelData())
}
