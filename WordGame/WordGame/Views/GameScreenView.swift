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
    @State var screenSize: CGSize = .zero
    
    var body: some View {
        GeometryReader { reader in
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
                AnswerView(screenSize: reader.size.width)
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
            .onReceive(store.state.timer, perform: { time in
                if store.state.roundTimeRemaining > 0 {
                    withAnimation(.linear(duration: Double(store.state.roundTimeRemaining))) {
                            store.dispatch(.startMovingAnswer)
                        }
                    } else {
                        store.dispatch(.noAnswer)
                    }
            })
            .onAppear {
                print(reader.size)
                store.dispatch(.startGame)
        }
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
