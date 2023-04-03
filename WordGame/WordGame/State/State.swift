//
//  State.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation

struct WordsGameState {
    var gameState: GameState = .title
    var words: Words = []
    var roundsCount: Int = 10
}
