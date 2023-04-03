//
//  WordsParser.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation

struct WordsParser {
    private let decoder = JSONDecoder()

    func parse(data: Data) throws -> [Word] {
        return try decoder.decode([Word].self, from: data)
    }
}
