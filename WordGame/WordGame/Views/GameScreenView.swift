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
                Spacer()
                Group {
                    Text("Right Answers: \(store.state.gameResults.rightAnswers)")
                    Text("Wrong Answers: \(store.state.gameResults.wrongAnswers)")
                    Text("No Answers: \(store.state.gameResults.noAnswers)")
                }
                .animation(nil)
                
                Spacer()
                QuestionView()
                Spacer()
                AnswerView(screenSize: reader.size.width, offset: 0)
                Spacer()
                HStack {
                    Spacer()
                    WrongButton()
                    Spacer()
                    CorrectButton()
                    Spacer()
                }
                Spacer()
                
            }
            .onAppear {
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
