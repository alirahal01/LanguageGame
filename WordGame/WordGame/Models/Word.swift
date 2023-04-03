//
//  Word.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation

// MARK: - Words
typealias Words = [Word]

// MARK: - Word
struct Word: Decodable, Equatable {
    let eng: String
    let spa: String

    // MARK: Decodable
    private enum CodingKeys: String, CodingKey {
        case eng = "text_eng"
        case spa = "text_spa"
    }
}
