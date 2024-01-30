//
//  ContentView.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

struct ContentView: View {
    
    @State var content: String = ""
    @State var isPresented: Bool = false
    @State var username: String = ""
    
    
    @EnvironmentObject var gameData: GameData
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "gamecontroller.fill")
                    .foregroundStyle(.pink)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Game Guide")
                    .font(.title)
                    .foregroundStyle(.pink)
                Spacer()
                if username.isEmpty{
                    Button(action: {isPresented = true}){
                        Text("Log in")
                            .foregroundStyle(.red)
                    }
                } else{
                    Button(action: {username = ""}){
                        Text("Log out")
                            .foregroundStyle(.red)
                    }
                }
            }
            .padding()
            Text("Stuck on a level? Look it up!")
                .padding(.top, 100)
                .padding(.leading)
                .font(.title2)
                .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
            Spacer()

            NavigationLink(destination: SearchView()) {
                Text("Search")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }


            HStack{
                Text("Or browse popular games")
                    .padding(.top, 100)
                    .padding(.leading)
                    .font(.title3)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))

                Spacer()
            }
            HStack{
                ForEach($gameData.games){ game in
                    GameGrid(game: game)
                }
                .listStyle(.automatic)
                .padding()
            }
            Spacer()
                
            .sheet(isPresented: $isPresented) {
                    LoginView(username: $username, isPresented: $isPresented)}
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GameData())
        .environmentObject(UserData())
}
