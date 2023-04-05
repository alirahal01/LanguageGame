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
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: 150, height: 150)
                .cornerRadius(12)
            VStack {
                Spacer()
                if let round = store.state.currentRound {
                    Text(round.answer)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        .minimumScaleFactor(0.05)
                }
                
                Spacer()
            }
        }
        .offset(x: store.state.moveAnswer ? 100 : -150)
        .shadow(radius: 8)
        .frame(width: 150, height: 150)
        
    }
}

struct AnswerView_Previews: PreviewProvider {
    @State static var timeRemaining = 5.0
    static var previews: some View {
        AnswerView()
            .environmentObject(WordsGameStore(
                initial: WordsGameState(),
                reducer: wordsGameReducer
            ))
    }
}
