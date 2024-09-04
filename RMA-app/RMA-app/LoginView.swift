//
//  LoginView.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import SwiftUI

struct LoginView: View {
    
    
    //@EnvironmentObject var userData: UserData
    @Binding var username: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack{
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
            
            Button(action: {isPresented = false}){
                Text("Log In")
            }
            .frame(width: 75, height: 40)
            .foregroundColor(.white)
            .background(Color.pink.opacity(0.8))
           // .border(Color.pink.opacity(0.8))
            .cornerRadius(12)
            }
    }
}


/*#Preview {
    LoginView(username: Binding.constant(""), isPresented: Binding.constant(true))
}
*/
