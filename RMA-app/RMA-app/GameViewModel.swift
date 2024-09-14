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
    func sanitizeUsername(_ username: String) -> String {
        let invalidCharacters = CharacterSet(charactersIn: ".#$[]")
        return username.components(separatedBy: invalidCharacters).joined(separator: "_")
    }

    // Function to save bookmarked game to Firebase Realtime Database
    func bookmarkGame(gameID: String, gameName: String, forUser username: String) {
        let sanitizedUsername = sanitizeUsername(username) // Sanitize username before using it
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
        let sanitizedUsername = sanitizeUsername(username) // Sanitize username before using it
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
        let sanitizedUsername = sanitizeUsername(username) // Sanitize username before using it
        ref.child("users").child(sanitizedUsername).child("savedGames").observeSingleEvent(of: .value) { snapshot in
            var games: [String] = []
            for child in snapshot.children {
                let gameSnapshot = child as! DataSnapshot
                let gameData = gameSnapshot.value as! [String: Any]
                if let gameID = gameData["gameID"] as? String {
                    games.append(gameID)
                }
            }
            completion(games)
        }
    }
}
