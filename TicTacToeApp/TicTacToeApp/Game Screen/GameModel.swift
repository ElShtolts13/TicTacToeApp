//
//  GameModel.swift
//  TicTacToeApp
//
//  Created by Максим Горячкин on 02.10.2024.
//

import Foundation

final class GameModel {
    
    struct AIMove {
        var index: Int
        var score: Int
    }
    
    // MARK: - Private properties
    
    private let isGameWithAI: Bool
    private let playerIsFirst: Bool
    private let difficult: Difficulty
    
    private let winCombinations = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    private let firstPlayer = "X"
    private let secondPLayer = "O"
    
    private var counter = 0
    private var currentPlayer: String {
        if counter.isMultiple(of: 2) {
            firstPlayer
        } else {
            secondPLayer
        }
    }
    
    private var aiPlayer: String {
        playerIsFirst ? secondPLayer : firstPlayer
    }
    
    private var humanPlayer: String {
        playerIsFirst ? firstPlayer : secondPLayer
    }
    
    private var currentGameState = Array(repeating: "", count: 9)
    
    // MARK: - Initialization
    
    init(isGameWithAI: Bool, playerIsFirst: Bool, difficult: Difficulty) {
        self.isGameWithAI = isGameWithAI
        self.playerIsFirst = playerIsFirst
        self.difficult = difficult
    }
    
    // MARK: - Public methods

    func move(at index: Int) {
        guard (0..<9).contains(index), currentGameState[index] == "" else {
            print(currentGameState)
            return
        }
        currentGameState[index] = currentPlayer
        print(currentGameState)
        checkWinner()
        checkNextMove()
    }
    
    func resetGame() {
        currentGameState = Array(repeating: "", count: 9)
        counter = 0
    }
    
    // MARK: - Private methods
    
    private func checkNextMove() {
        guard counter < 8 else {
            print("GAME OVER")
            return
        }
        guard isGameWithAI else {
            counter += 1
            return
        }
        moveWithAI()
    }
    
    private func moveWithAI() {
        guard isGameWithAI, let index = getMoveAI() else { return }
        currentGameState[index] = secondPLayer
        counter += 1
        print(currentGameState)
    }
    
    private func checkWinnig(for player: String) -> Bool {
        var firstMatch: Bool = false
        winCombinations.forEach { combination in
            var combinationResult = true
            combination.forEach {
                let result = currentGameState[$0-1] == player
                combinationResult = combinationResult && result
            }
            firstMatch = firstMatch || combinationResult
        }
        return firstMatch
    }
    
    private func checkWinner() {
        if checkWinnig(for: currentPlayer) {
            print("\(currentPlayer) IS WIN!!!")
        }
    }
    
    private func getMoveAI() -> Int? {
        switch difficult {
        case .easy:
            // Самая легкая сложность - возвращаем рандомный свободный сегмент
            let indexes = currentGameState.enumerated().filter { $0.element == "" }
            return indexes.randomElement()?.offset
        case .medium, .hard:
            // В зависимотси от сложности будем выбирать следующий ход
            let moves = getAIMoves()
            if moves.first?.score == 100 {
                return moves.first?.index
            } else if moves.first?.score == 80 {
                var move: AIMove = .init(index: 0, score: 0)
                moves.forEach {
                    if $0.score > move.score {
                        move = $0
                    }
                }
                return move.index
            } else {
                return 0
            }
        }
    }
    
    private func getAIMoves() -> [AIMove] {
        // Возвращаем массив ходов
        guard currentGameState[4] != "" else { return [.init(index: 4, score: 100)] } // Проверяем центральный сегмент
        guard currentGameState[0] != "", currentGameState[2] != "", currentGameState[6] != "", currentGameState[8] != "" else { return [.init(index: 0, score: 80), // Проверяем угловые сегменты
                                                                                                                                        .init(index: 2, score: 80),
                                                                                                                                        .init(index: 6, score: 80),
                                                                                                                                        .init(index: 8, score: 80)]}
        
        // Будут ходы в зависимости от сложности
        var moves = [AIMove]()
        
        return moves
    }
    
}
