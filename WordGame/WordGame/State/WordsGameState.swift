//
//  State.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation
import Combine
import SwiftUI

class WordsGameState {
    var gameState: GameState = .started
    var gameResults: GameResults = GameResults.empty
    var moveAnswer = false
    var rounds: Rounds = []
    @AppStorage("numberOfQuestions") private(set) var roundsCount = 10
    var currentRoundCount = 0
    var currentRound: Round? {
        if rounds.count > 0 && currentRoundCount < roundsCount {
            return rounds[currentRoundCount]
        } else {
            return nil
        }
    }
    
    @AppStorage("roundTime") var roundTime = 5
    var roundTimeRemaining = 0
    
    @Published var stopAnimationAndGoBack = false
    
    var secondsElapsed = 0
    var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    var connectedTimer: Cancellable? = nil
    
    func instantiateTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
            self.connectedTimer = self.timer.connect()
            return
        }
        
        func cancelTimer() {
            self.connectedTimer?.cancel()
            return
        }
        
        func resetCounter() {
            self.secondsElapsed = 0
            return
        }
        
        func restartTimer() {
            self.secondsElapsed = 0
            self.cancelTimer()
            self.instantiateTimer()
            return
        }
}

struct GameResults {
    var rightAnswers: Int
    var wrongAnswers: Int
    var noAnswers: Int
    
    static let empty = GameResults(rightAnswers: 0, wrongAnswers: 0, noAnswers: 0 )
}
