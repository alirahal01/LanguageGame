//
//  State.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation

struct WordsGameState {
    var gameState: GameState = .started
    var rounds: Rounds = []
    var roundsCount: Int = 5
    var currentRoundCount = 0
    var roundTime: TimeInterval = 5
    var gameResults: GameResults = GameResults.empty
    var currentRound: Round? {
        if rounds.count > 0 && currentRoundCount < roundsCount {
            return rounds[currentRoundCount]
        } else {
            return nil
        }
        
    }
}

struct GameResults {
    var rightAnswers: Int
    var wrongAnswers: Int
    var noAnswers: Int
    
    static let empty = GameResults(rightAnswers: 0, wrongAnswers: 0, noAnswers: 0 )
}
