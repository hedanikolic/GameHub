//
//  Game.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import Foundation
import UIKit

struct Game: Identifiable {
    var id = UUID().uuidString
    let gameName: String
    let imgURL: URL
    var isSaved: Bool
    var image: UIImage? = nil

}
