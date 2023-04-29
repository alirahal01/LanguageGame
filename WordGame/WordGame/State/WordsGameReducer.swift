//
//  Reducer.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation

typealias Reducer<State, Action> = (State, Action) -> State

let wordsGameReducer: Reducer<WordsGameState, WordsGameActions> = { state, action in
    var mutatingState = state
    switch action {
    case .startGame:
        let rounds = RoundsDataProvider.getRounds(with: WordsLoader(), roundsCount: state.roundsCount)
        mutatingState.roundTimeRemaining = Int(mutatingState.roundTime)
        mutatingState.rounds = rounds
        mutatingState.gameResults = .empty
        mutatingState.currentRoundCount = 0
        mutatingState.gameState = .started
        mutatingState.instantiateTimer()
        mutatingState.moveAnswer = true
        mutatingState.stopAnimationAndGoBack = false
    case .endGame:
        mutatingState.gameState = .started
    case .winGame:
        mutatingState.gameState = .ended
    case .correctPressed:
        mutatingState.stopAnimationAndGoBack = true
        guard let currentRound = state.currentRound else { return mutatingState }
        mutatingState.roundTimeRemaining = Int(mutatingState.roundTime)
        mutatingState.currentRoundCount += 1
        updateGameResults(currentRound: currentRound, correctPressed: true)
    case .wrongPressed:
        mutatingState.stopAnimationAndGoBack = true
        guard let currentRound = state.currentRound else { return mutatingState }
        mutatingState.roundTimeRemaining = Int(mutatingState.roundTime)
        mutatingState.currentRoundCount += 1
        updateGameResults(currentRound: currentRound, correctPressed: false)
    case .noAnswer:
        mutatingState.roundTimeRemaining = Int(mutatingState.roundTime)
        mutatingState.currentRoundCount += 1
        mutatingState.moveAnswer = false
        mutatingState.gameResults.noAnswers += 1
        if mutatingState.currentRoundCount == mutatingState.roundsCount {
            mutatingState.gameState = .ended
        }
    case .resetOffSetToZero:
        mutatingState.moveAnswer = false
    case .startMovingAnswer:
        mutatingState.stopAnimationAndGoBack = false
        mutatingState.moveAnswer = true
        mutatingState.roundTimeRemaining -= 1
        
    }
    
    func updateGameResults(currentRound: Round,correctPressed: Bool) {
        if correctPressed {
            if currentRound.isTranslationCorrect {
                mutatingState.gameResults.rightAnswers += 1
            } else {
                mutatingState.gameResults.wrongAnswers += 1
            }
        } else {
            if currentRound.isTranslationCorrect {
                mutatingState.gameResults.wrongAnswers += 1
            } else {
                mutatingState.gameResults.rightAnswers += 1
            }
        }
        if mutatingState.currentRoundCount == mutatingState.roundsCount {
            mutatingState.gameState = .ended
        }
    }
    
    return mutatingState
}
