//
//  LettersEditView.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/14/21.
//

import SwiftUI

struct LettersEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var game: GameOfSkateVC
    @State private var lettersContent: String = ""
    
    init(game: GameOfSkateVC) {
        self.game = game
    }
    
    var body: some View {
        VStack {
            Text("Edit Letters Here")
            Text(game.letters)
            TextField(game.letters, text: $lettersContent, onEditingChanged: { began in
                if !began {
//                    print("Edit ended: \(lettersContent)")
                    game.setLetters(to: lettersContent)
                    presentationMode.wrappedValue.dismiss()
                }
            }).onAppear(perform: {
                self.lettersContent = game.letters
            })
            .padding(.horizontal)
            
        }
    }
}

struct LettersEditView_Previews: PreviewProvider {
    static var previews: some View {
        LettersEditView(game: GameOfSkateVC(letters: "skate",
                                            playerNames: ["Skatet 1", "Skater 2", "Skater 3"]))
    }
}
