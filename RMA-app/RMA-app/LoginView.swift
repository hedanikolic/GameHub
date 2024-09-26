//
//  LoginView.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

struct LoginView: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var isPresented: Bool
    @State private var showRegisterView = false
    @State private var loginError: String? = nil  // State to show login error
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var gameData: GameData

    var body: some View {
        VStack {
            Image(systemName: "gamecontroller.fill")
                .foregroundStyle(Color.pink.opacity(0.8))
                .font(.title)
            Text("Log in")
                .font(.title)
                .foregroundStyle(Color.pink.opacity(0.8))
            TextField("Username", text: $username)
                .frame(width: 300, height: 30)
                .border(.secondary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 15)
            SecureField("Password", text: $password)
                .frame(width: 300, height: 30)
                .border(.secondary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 15)
            
            if let error = loginError {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.bottom)
            }
            
            Button(action: {
                gameViewModel.validateUser(username: username, password: password) { success, error in
                    if success {
                        isPresented = false  // Close the login view
                        gameViewModel.loadSavedGames(forUser: username) { savedGames in
                            userData.savedGamesID = savedGames
                            gameData.markGamesAsSaved(savedGames)
                        }
                    } else {
                        loginError = error  // Show login error
                    }
                }
            }) {
                Text("Log In")
            }
            .frame(width: 75, height: 40)
            .foregroundColor(.white)
            .background(Color.pink.opacity(0.8))
            .cornerRadius(12)
            .padding(.bottom)
            
            Text("Don't have an account?")
                .padding(.bottom)
                .padding(.leading)
                .font(.body)
                .foregroundColor(.primary)
            
            Button(action: {showRegisterView = true; userData.username = ""; userData.password = ""}) {
                Text("Register")
                    .frame(width: 90, height: 40)
                    .foregroundColor(.white)
                    .background(Color.pink.opacity(0.8))
                    .cornerRadius(12)
            }
        }
        .sheet(isPresented: $showRegisterView) {
            RegisterView(username: $userData.username, password: $userData.password, isPresented: $isPresented)
        }
    }
}
