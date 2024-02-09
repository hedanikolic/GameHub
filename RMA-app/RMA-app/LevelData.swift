//
//  LevelData.swift
//  RMA-app
//
//  Created by student on 09.02.2024..
//

import Foundation
import Combine

class LevelData: ObservableObject {
    static let shared = LevelData()
    private init(){}
    
    @Published var levels: [Level] = [
        Level(name: "Level 1: The Forest Trail", content: "The player starts their journey through a dense forest. They must navigate through the winding trails, avoiding obstacles like fallen trees and wild animals."),
           Level(name: "Level 2: The Ancient Ruins", content: "The player discovers a hidden entrance to ancient ruins buried deep within the forest. Inside, they encounter puzzles and traps left by the ancient civilization."),
          Level(name: "Level 3: The Crystal Caves", content: "After escaping the ruins, the player finds themselves in a network of crystal caves. The caves are filled with glowing crystals and mysterious creatures."),
           Level(name: "Level 4: The Lava Chamber", content: "Deep within the crystal caves, the player discovers a chamber filled with molten lava. Platforms float above the lava, and the air shimmers with heat."),
           Level(name: "Level 5: The Skyward Ascent", content: "As the player emerges from the caves, they find themselves at the foot of a towering mountain. The only way forward is to climb to the summit.")
       ]
}
