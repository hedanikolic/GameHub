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
        Game(gameName: "The Legend of Zelda: Breath of the Wild", imgURL: URL(string: "https://cdn.mobygames.com/covers/8437192-the-legend-of-zelda-breath-of-the-wild-nintendo-switch-front-cov.jpg")!, isSaved: false),
        Game(gameName: "Little Nightmares", imgURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/d/d8/Little_Nightmares_Box_Art.png")!, isSaved: false),
        Game(gameName: "Heavy Rain", imgURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/c/c1/Heavy_Rain_Cover_Art.jpg")!, isSaved: false),
        Game(gameName: "Red Dead Redemption II", imgURL: URL(string: "https://assets.vg247.com/current//2018/05/red_dead_redemption_2_cover_art_1.jpg")!, isSaved: false),
        Game(gameName: "Diablo IV", imgURL: URL(string: "https://assets-prd.ignimgs.com/2021/12/17/diablo-iv-button-2021-1639768661633.jpg")!, isSaved: false),
        Game(gameName: "The Last of Us: Part I", imgURL: URL(string: "https://www.truetrophies.com/boxart/Game_17496.jpg")!, isSaved: false)
        
    ]
    
    func markGamesAsSaved(_ savedGameIDs: [String]) {
        // Reset all games' isSaved state before marking
        for index in games.indices {
            games[index].isSaved = false
        }

        // Mark only the games that belong to the current user
        for gameID in savedGameIDs {
            if let index = games.firstIndex(where: { $0.id == gameID }) {
                games[index].isSaved = true
                print("Marked as saved: \(games[index].gameName)")
            } else {
                print("Game not found for ID: \(gameID)")
            }
        }
    }

    
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
    
    func getSavedGamesWithBindings(inds: [String]) -> [Binding<Game>] {
            return games.compactMap { game in
                if inds.contains(game.id) && game.isSaved {
                    return Binding(
                        get: { game },
                        set: { newValue in
                            if let index = self.games.firstIndex(where: { $0.id == game.id }) {
                                self.games[index] = newValue
                            }
                        }
                    )
                } else {
                    return nil
                }
            }
        }
    
    func clearSavedGames() {
            for index in games.indices {
                games[index].isSaved = false
            }
        }
    
}

