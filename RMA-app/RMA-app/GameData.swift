//
//  GameData.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import Foundation
import Combine
import SwiftUI

class GameData: ObservableObject {
    @Published var games: [Game] = [
        Game(gameName: "The Legend of Zelda: Breath of the Wild", imgURL: URL(string: "https://e.snmc.io/lk/lv/x/eea8ccf5129cb92cab07d8fb363be933/8378753")!, isSaved: false),
        Game(gameName: "Little Nightmares", imgURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/d/d8/Little_Nightmares_Box_Art.png")!, isSaved: false),
        Game(gameName: "Heavy Rain", imgURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/c/c1/Heavy_Rain_Cover_Art.jpg")!, isSaved: false),
        Game(gameName: "Red Dead Redemption II", imgURL: URL(string: "https://assets.vg247.com/current//2018/05/red_dead_redemption_2_cover_art_1.jpg")!, isSaved: false),
        Game(gameName: "Heavy Rain", imgURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/c/c1/Heavy_Rain_Cover_Art.jpg")!, isSaved: false),
        Game(gameName: "Heavy Rain", imgURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/c/c1/Heavy_Rain_Cover_Art.jpg")!, isSaved: false)
        
    ]
    
    
    func getGames(inds: [String]) -> [Game]{
        return games.filter { game in
            return inds.contains(game.id)
        }
    }
}
