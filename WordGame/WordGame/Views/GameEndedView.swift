//
//  GameEndedView.swift
//  WordGame
//
//  Created by ali rahal on 04/04/2023.
//

import SwiftUI

struct GameEndedView: View {
    @EnvironmentObject var store: WordsGameStore
    var body: some View {
        VStack {
            Text("Right Answers: \(store.state.gameResults.rightAnswers)")
            Text("Wrong Answers: \(store.state.gameResults.wrongAnswers)")
            Text("No Answers: \(store.state.gameResults.noAnswers)")
            Button {
                store.dispatch(.startGame)
            } label: {
                Text("ok")
            }
        }
        

    }
}

struct GameEndedView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreenView()
            .environmentObject(WordsGameStore(
                initial: WordsGameState(),
          reducer: wordsGameReducer
        ))
    }
}
