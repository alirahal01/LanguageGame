//
//  Reducer.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation

typealias Reducer<State, Action> = (State, Action) -> State

let wordsGameReducer: Reducer<WordsGameState, WordsGameAction> = { state, action in
    var mutatingState = state
    switch action {
        
    case .startGame:
        let words = RoundsDataProvider.getRounds(with: WordsLoader(), roundsCount: 10)
        mutatingState.gameState = .started
    case .endGame:
        mutatingState.gameState = .title
    case .winGame:
        mutatingState.gameState = .won
    }
    return mutatingState
}
