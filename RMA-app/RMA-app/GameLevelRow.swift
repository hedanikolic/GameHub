//
//  GameLevelView.swift
//  RMA-app
//
//  Created by student on 09.02.2024..
//

import SwiftUI

struct GameLevelRow: View {
    
    @Binding var level: Level
    @State private var isExpanded = false
    
    var body: some View {
        VStack{
            HStack{
                Text(level.name)
                    .padding()
                    .font(.title2)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                    .padding()
            }
            if isExpanded {
                Text(level.content)
                    .padding()
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .onTapGesture {
            isExpanded.toggle()
        }
    }
}

#Preview {
    GameLevelRow(level: Binding.constant(
    Level(name: "Level 1: Introduction", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")))
}