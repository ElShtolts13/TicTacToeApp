//
//  Model.swift
//  TicTacToeApp
//
//  Created by salfetkafive on 30.09.2024.
//

import Foundation
struct SelectGameSettings {
    var isSinglePlayer: Bool
    var difficulty: Difficulty = .easy
    var gameTime: TimeInterval
}

enum Difficulty {
    case easy, medium, hard
}
