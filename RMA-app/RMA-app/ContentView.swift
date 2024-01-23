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
            
            Spacer()
                .sheet(isPresented: $isPresented) {
                    LoginView(username: $username, isPresented: $isPresented)}
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserData())
}
