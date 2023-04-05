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
                .offset(x: store.state.moveAnswer ? geometry.size.width - 150 : 0)
                .shadow(radius: 8)
            .frame(width: 150, height: 150)
            }
        }
        .frame(width: screenSize, height: 150)
    }
}

struct AnswerView_Previews: PreviewProvider {
    @State static var testSize = 300
    static var previews: some View {
        AnswerView(screenSize: 0)
            .environmentObject(WordsGameStore(
                initial: WordsGameState(),
                reducer: wordsGameReducer
            ))
    }
}
