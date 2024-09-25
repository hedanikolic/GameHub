//
//  GameViewModel.swift
//  RMA-app
//
//  Created by Heda Nikolić on 06.09.2024..
//

import SwiftUI
import FirebaseDatabase
import Combine

class GameViewModel: ObservableObject {
    private let ref = Database.database().reference()

    // Helper function to sanitize the username
    func sanitizeUsername(_ username: String) -> String? {
        let invalidCharacters = CharacterSet(charactersIn: ".#$[]")
        let sanitizedUsername = username.components(separatedBy: invalidCharacters).joined(separator: "_")
        
        return sanitizedUsername.isEmpty ? nil : sanitizedUsername // Ensure username isn't empty after sanitization
    }





    // Function to save bookmarked game to Firebase Realtime Database
    func bookmarkGame(gameID: String, gameName: String, forUser username: String) {
        guard let sanitizedUsername = sanitizeUsername(username) else {
            print("Error: Invalid or empty username.")
            return
        }
        ref.child("users").child(sanitizedUsername).child("savedGames").child(gameID).setValue([
            "gameID": gameID,
            "gameName": gameName
        ]) { error, _ in
            if let error = error {
                print("Error saving bookmark to Realtime Database: \(error.localizedDescription)")
            } else {
                print("Game bookmarked successfully!")
            }
        }
    }

    
    
    // Function to remove un-bookmarked game from Firebase Realtime Database
    func removeBookmarkedGame(gameID: String, forUser username: String) {
        guard let sanitizedUsername = sanitizeUsername(username) else {
            print("Error: Invalid or empty username.")
            return
        }
        ref.child("users").child(sanitizedUsername).child("savedGames").child(gameID).removeValue { error, _ in
            if let error = error {
                print("Error removing bookmark from Realtime Database: \(error.localizedDescription)")
            } else {
                print("Game un-bookmarked successfully!")
            }
        }
    }

    // Function to load saved games from Firebase Realtime Database
    func loadSavedGames(forUser username: String, completion: @escaping ([String]) -> Void) {
        print("Original username passed to loadSavedGames: \(username)")  // Log the username before sanitization
        
        guard let sanitizedUsername = sanitizeUsername(username) else {
            print("Error: Invalid or empty username.")
            completion([])  // Return an empty list if username is invalid
            return
        }
        
        print("Loading saved games for user: \(sanitizedUsername)")
        
        ref.child("users").child(sanitizedUsername).child("savedGames").observeSingleEvent(of: .value) { snapshot in
            var games: [String] = []
            print("Snapshot found: \(snapshot.exists())")  // Check if snapshot exists
            for child in snapshot.children {
                let gameSnapshot = child as! DataSnapshot
                let gameData = gameSnapshot.value as! [String: Any]
                print("Game data: \(gameData)")  // Log game data retrieved

                if let gameID = gameData["gameID"] as? String {
                    games.append(gameID)
                    print("Game ID added: \(gameID)")  // Log each game ID added
                }
            }
            completion(games)
        }
    }

}
