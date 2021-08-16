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
        VStack(alignment: .center) {
            headerStack
            VStack {
                textStack
                letterTemplates
            }
            .padding(.horizontal)
            Spacer()
        }
    }
    
    // MARK: - header stack
    var headerStack: some View {
        VStack {
            Text("Edit Letters Here")
                .fontWeight(.heavy)
                .padding(.vertical)
                .font(.title)
            Text("\"\(game.letters)\": \(game.letters.count) letters")
                .font(.title2)
                .fontWeight(.heavy)
            HStack { Spacer() }
        }
            .foregroundColor(Color.white)
            .padding()
            .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
    }
    
    // MARK: - text stack
    var textStack: some View {
        VStack {
            Text("You can enter your customized text:")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color.purple)
                
            HStack {
                Spacer()
                ZStack {
                    TextField(game.letters, text: $lettersContent, onEditingChanged: { began in
                        if !began {
                            game.setLetters(to: lettersContent)
                            presentationMode.wrappedValue.dismiss()
                        }
                    })
                        .autocapitalization(.allCharacters)
                        .disableAutocorrection(true)
                        .onAppear(perform: {
                            self.lettersContent = game.letters
                        })
                        .padding(.all)
                        .padding(.leading)
                        .padding(.trailing)
                        .foregroundColor(.purple)
                        .zIndex(1)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .frame(height: 40.0)
                        .foregroundColor(.purple)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.purple)
                        .frame(height: 40.0)
                        .opacity(0.2)
                }
            }
        }
        .padding(.vertical)
    }
    
    // MARK: - letter templates
    var letterTemplates: some View {
        VStack {
            Text("Or choose from these templates:")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color.purple)
            
            ForEach(GameModel.getLettersOptions(), id: \.self) { letterTemplate in
                Button (action: {
                    game.setLetters(to: letterTemplate)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(letterTemplate)
                        .padding(.horizontal, 14.0)
                        .padding(.vertical, 9.0)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                        )
                })
                .padding(.vertical, 8.0)
            }
        }
    }
}

struct LettersEditView_Previews: PreviewProvider {
    static var previews: some View {
        LettersEditView(game: GameOfSkateVC(letters: "SKATE",
                                            playerNames: ["Skater 1", "Skater 2", "Skater 3"]))
    }
}
