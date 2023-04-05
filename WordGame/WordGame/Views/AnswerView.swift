//
//  AnswerView.swift
//  WordGame
//
//  Created by ali rahal on 05/04/2023.
//

import SwiftUI
import Combine

struct AnswerView: View {
    @EnvironmentObject var store: WordsGameStore
    @Binding var timeRemaining: TimeInterval
    
    var body: some View {
        if let round = store.state.currentRound {
            Text(round.answer)
                .animation(.easeOut)
                .onChange(of: timeRemaining, perform: { timeRemaining in
                    withAnimation(.linear(duration: 5)) {
                        if timeRemaining > 0 {
//                            self.timeRemaining -= 1
                            store.dispatch(.startMovingAnswer)
                        } else {
//                            self.timeRemaining = 5
                            store.dispatch(.noAnswer)
                        }
                    }
                })
                .offset(x: store.state.moveAnswer ? 150 : -150)
            
        }
    }
}
    
    struct AnswerView_Previews: PreviewProvider {
        @State static var timeRemaining = 5.0
        static var previews: some View {
            AnswerView(timeRemaining: $timeRemaining)
                .environmentObject(WordsGameStore(
                    initial: WordsGameState(),
                    reducer: wordsGameReducer
                ))
        }
    }
