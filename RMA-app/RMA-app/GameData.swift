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
        Game(gameName: "Diablo IV", isSaved: false)
        
    ]
    /*func getTweets(inds: [String]) -> [Tweet]{
        return tweets.filter { tweet in
            return inds.contains(tweet.id)
        }
    }*/
}
