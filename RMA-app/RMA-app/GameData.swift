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
    
    let games_url = URL(string: "https://gamehub-d7ecc-default-rtdb.europe-west1.firebasedatabase.app/games.json")!
    
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
    
    func sendGame(game: Game) async
    {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(game)
            
            
            var request = URLRequest(url: games_url)
            request.httpMethod = "POST"
            request.httpBody = json
            
            let (_, response) = try await URLSession.shared.data(for: request)
            print(response)
        }catch let error {
            print(error)
        }
    }
    
    func fetchGames() async
    {
        do {
            let (data, _) = try await URLSession.shared.data(from: games_url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decoded_games = try decoder.decode([String: Game].self, from: data)
            games = [Game](decoded_games.values)
        } catch let error {
            print(error)
        }
    }
}


