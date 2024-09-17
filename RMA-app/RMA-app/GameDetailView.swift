//
//  GameDetailView.swift
//  RMA-app
//
//  Created by student on 08.02.2024..
//

import SwiftUI

struct GameDetailView: View {
    
    @Binding var game: Game
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var levelData: LevelData
    @State private var loadedImage: UIImage?
    @StateObject var gameViewModel = GameViewModel()
    
    var body: some View {
        VStack{
            HStack{
                if let image = loadedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Text("Image Loading Failed")
                }
                
                HStack{
                    Text(game.gameName)
                        .font(.system(size: 27))
                        .foregroundColor(.pink)
                    
                    Spacer()
                    
                }
                // Saving games into Firebase
                
                Button(action: {
                    guard !userData.username.isEmpty else {
                            print("User is not logged in. Bookmarking is disabled.")
                            return // Prevent action if not logged in
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
                    Image(systemName: game.isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(Color.pink.opacity(0.8))
                        .font(.title2)
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
                            .foregroundStyle(.pink)
                            .font(.title2)
                    } else {Image(systemName: "bookmark")
                            .foregroundStyle(.pink)
                            .font(.title2)
                    }
                }*/
            }
            .padding()
            Spacer()
            
            HStack{
                Text("Levels:")
                    .padding()
                    .font(.system(size: 25))
                    .foregroundStyle(.pink)
                Spacer()
            }
            
            
            ScrollView {
                LazyVStack {
                    ForEach(levelData.levels.filter { $0.gameName == game.gameName }) {level in
                            GameLevelRow(level: level)
                        }
                }
            }
            
            Spacer()
        }
        .onAppear(perform: {
            loadImageAsync(from: self.game.imgURL) { image in
                        self.loadedImage = image
                    }
                })

    }
}

#Preview {
    GameDetailView(game: Binding.constant(
        Game(gameName: "The Legend of Zelda: Breath of the Wild", imgURL: URL(string:"https://e.snmc.io/lk/lv/x/eea8ccf5129cb92cab07d8fb363be933/8378753")!, isSaved: true)
    ))
    .environmentObject(GameData())
    .environmentObject(LevelData())
}
