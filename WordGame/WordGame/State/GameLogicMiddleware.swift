//
//  GameLogicMiddleware.swift
//  WordGame
//
//  Created by ali rahal on 05/04/2023.
//

import Foundation

import Combine

let gameLogic: Middleware<WordsGameState, WordsGameActions> =
{ state, action in
    switch action {
    case .correctPressed, .wrongPressed:
        break
    default:
        break
    }
    return Empty().eraseToAnyPublisher()
}
