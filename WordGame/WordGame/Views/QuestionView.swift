//
//  QuestionView.swift
//  WordGame
//
//  Created by ali rahal on 05/04/2023.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var store: WordsGameStore
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: 150, height: 150)
                .cornerRadius(12)
            if let round = store.state.currentRound {
                Text(round.question)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(10)
                    .minimumScaleFactor(0.05)
            }
        }
        .shadow(radius: 8)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(WordsGameStore(
                initial: WordsGameState(),
                reducer: wordsGameReducer
            ))
    }
}
