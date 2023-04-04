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
        let rounds = RoundsDataProvider.getRounds(with: WordsLoader(), roundsCount: 5)
        mutatingState.rounds = rounds
        mutatingState.gameResults = .empty
        mutatingState.currentRoundCount = 0
        mutatingState.gameState = .started
    case .endGame:
        mutatingState.gameState = .started
    case .winGame:
        mutatingState.gameState = .ended
    case .correctPressed:
        
        mutatingState.currentRoundCount += 1
        guard let currentRound = state.currentRound else { return mutatingState }
        if currentRound.isTranslationCorrect {
            mutatingState.gameResults.rightAnswers += 1
        } else {
            mutatingState.gameResults.wrongAnswers += 1
        }
        if mutatingState.currentRoundCount == mutatingState.roundsCount {
            mutatingState.gameState = .ended
        }
        
    case .wrongPressed:
        
        guard let currentRound = state.currentRound else { return mutatingState }
        mutatingState.currentRoundCount += 1
        if currentRound.isTranslationCorrect {
            mutatingState.gameResults.wrongAnswers += 1
        } else {
            mutatingState.gameResults.rightAnswers += 1
        }
        if mutatingState.currentRoundCount == mutatingState.roundsCount {
            mutatingState.gameState = .ended
        }
    }
    return mutatingState
}
