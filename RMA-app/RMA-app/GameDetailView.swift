//
//  GameDetailView.swift
//  RMA-app
//
//  Created by student on 08.02.2024..
//

import SwiftUI

struct GameDetailView: View {
    var game: Game
    
    let imageURL = URL(string: "https://e.snmc.io/lk/lv/x/eea8ccf5129cb92cab07d8fb363be933/8378753")!
    var loadedImage: UIImage? {
            loadImage(from: game)
        }
    
    var body: some View {
        HStack{
            if let image = game.imgURL {
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
            }
        }
    }

#Preview {
    GameDetailView(game: Game(gameName: "Heavy Rain", imgURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/c/c1/Heavy_Rain_Cover_Art.jpg")!, isSaved: true))
}
