//
//  UserData.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import Foundation
import Combine

class UserData: ObservableObject{
    @Published var username = ""
    @Published var savedGamesID: [String] = []
}
