//
//  WordsLoader.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation

struct WordsLoader {
    
    // MARK: - Load Words
    ///  returns list of words
    ///
    /// - Parameters:
    ///   - fileName: String.
    ///   - Parser: WordsPaser

    /// - Returns: Words
    ///
    ///
    func loadWords(with fileName: String, parser: WordsParser) -> Words {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil),
            let data = try? Data(contentsOf: url),
            let translatedWords = try? parser.parse(data: data) else {
                fatalError("Failure in reading words!")
        }
        return translatedWords
    }
}
