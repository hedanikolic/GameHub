//
//  LoginView.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

struct LoginView: View {
    
    @Binding var username: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack{
            Image(systemName: "gamecontroller.fill")
                .foregroundStyle(.pink)
                .font(.title)
            Text("Log in")
                .font(.title)
                .foregroundStyle(.pink)
            TextField("Username", text: $username)
                .frame(width: 300, height: 30)
                .border(.secondary)
                .multilineTextAlignment(.center)
            
            Button(action: {isPresented = false}){
                Text("Log In")
            }
            .padding(.vertical)
            .frame(width: 75, height: 40)
            .foregroundColor(.white)
            .background(Color.pink.opacity(0.8))
            .border(.secondary)
            .cornerRadius(10)
            }
    }
}

#Preview {
    LoginView(username: Binding.constant(""), isPresented: Binding.constant(true))
}
