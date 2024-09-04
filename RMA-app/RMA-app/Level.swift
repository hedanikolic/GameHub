//
//  Level.swift
//  RMA-app
//
//  Created by student on 09.02.2024..
//

import Foundation

struct Level: Identifiable{
    var id = UUID().uuidString
    let gameName : String
    let name: String
    var content: String
}
