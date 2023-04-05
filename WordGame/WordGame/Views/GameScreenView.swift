//
//  GameScreenView.swift
//  WordGame
//
//  Created by ali rahal on 04/04/2023.
//

import SwiftUI

extension AnyTransition {
    static var wordTextTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
        let removal = AnyTransition.scale
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
struct GameScreenView: View {
    @EnvironmentObject var store: WordsGameStore
    @State private var roundTimeRemaining = 5.0
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Group {
                Text("Right Answers: \(store.state.gameResults.rightAnswers)")
                Text("Wrong Answers: \(store.state.gameResults.wrongAnswers)")
                Text("No Answers: \(store.state.gameResults.noAnswers)")
            }
            .animation(nil)
            
            Spacer()
            if let round = store.state.currentRound {
                Text(round.question)
                    .animation(nil)
            }
            Spacer()
//            AnswerView(timeRemaining: $roundTimeRemaining)
            if let round = store.state.currentRound {
                Text(round.answer)
                    .animation(.easeOut)
                    .offset(x: store.state.moveAnswer ? 150 : -150)
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
        .onReceive(timer, perform: { time in
                if roundTimeRemaining > 0 {
                    withAnimation(.linear(duration: 5)) {
                        roundTimeRemaining -= 1
                        store.dispatch(.startMovingAnswer)
                    }
                    
                } else {
                    roundTimeRemaining = 5
                    store.dispatch(.noAnswer)
                }
        })
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
