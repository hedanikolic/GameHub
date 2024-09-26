//
//  RegisterView.swift
//  RMA-app
//
//  Created by Heda Nikolić on 26.09.2024..
//

import SwiftUI

struct RegisterView: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var isPresented: Bool
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var gameData: GameData

    @State private var registrationError: String? // To display any error messages

    var body: some View {
        VStack {
            Image(systemName: "gamecontroller.fill")
                .foregroundStyle(Color.pink.opacity(0.8))
                .font(.title)
            Text("Register")
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
            
            if let error = registrationError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.bottom, 15)
            }
            
            Button(action: {
                gameViewModel.registerUser(username: username, password: password) { success in
                    if success {
                        isPresented = false  // Close the registration view if successful
                    } else {
                        registrationError = "Username already exists. Please choose another one."
                    }
                }
            }) {
                Text("Register")
            }
            .frame(width: 90, height: 40)
            .foregroundColor(.white)
            .background(Color.pink.opacity(0.8))
            .cornerRadius(12)
        }
        .padding()
    }
}
