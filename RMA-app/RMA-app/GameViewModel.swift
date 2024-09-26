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
    
    
    // Function to check if the username already exists
        func checkUsernameExists(username: String, completion: @escaping (Bool) -> Void) {
            ref.child("users").child(username).observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    completion(true)  // Username already exists
                } else {
                    completion(false) // Username doesn't exist
                }
            }
        }

        // Function to register a new user in Firebase
    func registerUser(username: String, password: String, completion: @escaping (Bool) -> Void) {
        checkUsernameExists(username: username) { exists in
            if exists {
                completion(false)  // Username is already taken
            } else {
                // Save new user to Firebase
                let userData = ["username": username, "password": password]
                self.ref.child("users").child(username).setValue(userData) { error, _ in
                    if let error = error {
                        print("Error registering user: \(error.localizedDescription)")
                        completion(false)
                    } else {
                        print("User registered successfully!")
                        completion(true)
                    }
                }
            }
        }
    }
    
    // Check if username and password match
        func validateUser(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
            ref.child("users").child(username).observeSingleEvent(of: .value) { snapshot in
                if let userData = snapshot.value as? [String: Any],
                   let storedPassword = userData["password"] as? String {
                    if storedPassword == password {
                        completion(true, nil)  // Login successful
                    } else {
                        completion(false, "Wrong password.")  // Password doesn't match
                    }
                } else {
                    completion(false, "User not found.")  // Username doesn't exist
                }
            }
        }

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
