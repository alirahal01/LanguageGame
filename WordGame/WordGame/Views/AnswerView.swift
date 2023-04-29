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
    @State var screenSize: CGFloat
    @State var offset: CGFloat
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 150, height: 150)
                        .cornerRadius(12)
                    if let round = store.state.currentRound {
                        Text(round.answer)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(10)
                            .minimumScaleFactor(0.05)
                    }
                }
                .offset(x: offset)
                .shadow(radius: 8)
                .onChange(of: offset, perform: { newValue in
                    if offset == 0 {
                        self.store.dispatch(.startMovingAnswer)
                    }
                })
                .onChange(of: store.state.roundTimeRemaining, perform: { newValue in
                    if store.state.stopAnimationAndGoBack {
                        offset = 0
                    } else {
                        if store.state.moveAnswer {
                            withAnimation(.linear(duration: Double(store.state.roundTimeRemaining))) {
                                offset = geometry.size.width - 150
                            }
                        } else {
                            offset = 0
                        }
                    }
                    
                })
                .onReceive(store.state.$stopAnimationAndGoBack, perform: { result in
                    if result { store.dispatch(.resetOffSetToZero) }
                })
                .onReceive(store.state.timer, perform: { time in
                    if store.state.roundTimeRemaining > 0 {
                        if !store.state.stopAnimationAndGoBack {
                            store.dispatch(.startMovingAnswer)
                        }
                    } else {
                        store.dispatch(.noAnswer)
                    }
                })
                .frame(width: 150, height: 150)
            }
        }
        .frame(width: screenSize, height: 150)
    }
}

struct AnswerView_Previews: PreviewProvider {
    @State static var testSize = 300
    static var previews: some View {
        AnswerView(screenSize: 0,offset: 0)
            .environmentObject(WordsGameStore(
                initial: WordsGameState(),
                reducer: wordsGameReducer
            ))
    }
}
