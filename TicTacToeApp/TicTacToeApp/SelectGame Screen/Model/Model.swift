//
//  Model.swift
//  TicTacToeApp
//
//  Created by salfetkafive on 30.09.2024.
//

import Foundation
struct SelectGameSettings {
    var isSinglePlayer: Bool
    var difficulty: Difficulty?
}

enum Difficulty {
    case easy, medium, hard
}
