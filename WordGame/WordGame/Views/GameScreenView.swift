//
//  GameScreenView.swift
//  WordGame
//
//  Created by ali rahal on 04/04/2023.
//

import SwiftUI

struct GameScreenView: View {
    @EnvironmentObject var store: WordsGameStore
    var body: some View {
        VStack {
            Text("Right Answers: \(store.state.gameResults.rightAnswers)")
            Text("Wrong Answers: \(store.state.gameResults.wrongAnswers)")
            Spacer()
            if let round = store.state.currentRound {
                Text(round.question)
            }
            Spacer()
            if let round = store.state.currentRound {
                Text(String(round.isTranslationCorrect))
            }
            Spacer()
            HStack {
                Spacer()
                Button {
                    self.store.dispatch(.correctPressed)
                } label: {
                    Text("Correct")
                }
                Spacer()
                Button {
                    self.store.dispatch(.wrongPressed)
                } label: {
                    Text("Incorrect")
                }
                Spacer()
            }
        }
        .onAppear {
            store.dispatch(.startGame)
        }
    }
}

struct GameScreenView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreenView()
            .environmentObject(WordsGameStore(
                initial: WordsGameState(),
          reducer: wordsGameReducer
        ))
    }
}
