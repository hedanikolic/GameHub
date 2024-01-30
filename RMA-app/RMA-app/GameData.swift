//
//  GameData.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import Foundation
import Combine

class GameData: ObservableObject {
    @Published var games: [Game] = [
        Game(gameName: "The Legend of Zelda: Breath of the Wild", imgURL: URL(string: "https://e.snmc.io/lk/lv/x/eea8ccf5129cb92cab07d8fb363be933/8378753")!, isSaved: false),
        Game(gameName: "Little Nightmares", imgURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/d/d8/Little_Nightmares_Box_Art.png")!, isSaved: false)
        
    ]
    
    
    /*func getTweets(inds: [String]) -> [Tweet]{
        return tweets.filter { tweet in
            return inds.contains(tweet.id)
        }
    }*/
}
