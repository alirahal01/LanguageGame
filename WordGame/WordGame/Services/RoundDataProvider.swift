//
//  RoundData.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation

struct RoundsDataProvider {
    static func getRounds(with wordsLoader: WordsLoader, roundsCount: Int) -> Rounds {
        let allWords = wordsLoader.loadWords(with: "words.json", parser: WordsParser())
        let shuffledPrefix = allWords.shuffled().prefix(roundsCount)
        let half = roundsCount/2
        let halfOfRoundsCorrect = shuffledPrefix.prefix(half).map {
            return Round(question: $0.eng,
                         answer: $0.spa,
                             isTranslationCorrect: true)
        }
        let halfOfRoundsCorrectOrNot: [Round] = shuffledPrefix.suffix(roundsCount-half).map {
            let allPossibleTranslations = Set(allWords.map {$0.spa})
            let answerWord = allPossibleTranslations.randomElement() ?? $0.spa
            return Round(question: $0.eng,
                         answer: answerWord,
                             isTranslationCorrect: answerWord == $0.spa)
        }
        return (halfOfRoundsCorrect + halfOfRoundsCorrectOrNot).shuffled()
    }
}
