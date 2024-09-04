//
//  ProfileView.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var gameData: GameData
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var levelData: LevelData
    //@Binding var username: String
    @State var isPresented: Bool = false
    
    var body:some View {
        GeometryReader{ geometry in
            VStack{
            
                HStack {
                    Image(systemName: "gamecontroller.fill")
                        .foregroundStyle(Color.pink.opacity(0.8))
                        .font(.title)
                    Text("Game Guide")
                        .font(.title)
                        .foregroundStyle(Color.pink.opacity(0.8))
                    Spacer()
                }
                .padding()
                
                VStack{
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.secondary)
                    //.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    Text(userData.username)
                        .font(.title)
                        .foregroundStyle(Color.pink.opacity(0.8))
                    //.padding()
                }
                .padding(.vertical, 30)
                
                HStack{
                    Text("Saved Games")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .padding()
                    Spacer()
                }
                if userData.username.isEmpty{
                    VStack{
                        Text("Log in to see saved games!")
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                        Button(action: {isPresented = true}){
                            Text("Log in")
                                .frame(width: 85, height: 45)
                                .foregroundColor(.white)
                                .background(Color.pink.opacity(0.8))
                            // .border(Color.pink.opacity(0.8))
                                .cornerRadius(12)
                                .font(.title2)
                        }
                    }
                }
                else{
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 0),
                            GridItem(.flexible(), spacing: 0)
                        ], spacing: 30) {
                            ForEach(gameData.getSavedGamesWithBindings(inds: userData.savedGamesID)) { gameBinding in
                                GameGrid(game: gameBinding)
                            }
                        }
                        .padding()
                        
                        Spacer()
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            //.background(Color.red.opacity(0.2))
            //.frame(height: UIScreen.main.bounds.height)
            .sheet(isPresented: $isPresented) {
                LoginView(username: $userData.username, isPresented: $isPresented)}
        }
    }
}


        
#Preview {
    ProfileView()
        .environmentObject(GameData())
        .environmentObject(UserData())
        .environmentObject(LevelData())
}
