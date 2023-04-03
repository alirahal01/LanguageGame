//
//  Round.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation

typealias Rounds = [Round]

struct Round: Equatable {
    let question: String
    let answer: String
    let isTranslationCorrect: Bool
}
