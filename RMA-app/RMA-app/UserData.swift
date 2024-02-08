//
//  UserData.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import Foundation
import Combine

class UserData: ObservableObject{
    @Published var username = "heda"
    @Published var imageName = "DiabloIV"
    @Published var myAnswersID: [String] = []
    @Published var savedAnswersID: [String] = []
    @Published var savedGamesID: [String] = []
}
