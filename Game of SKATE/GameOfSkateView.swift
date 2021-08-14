//
//  ContentView.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/3/21.
//

import SwiftUI

struct GameOfSkateView: View {
    
    @ObservedObject var game: GameOfSkateVC
    @State private var showImagePicker = false
    
    init(game: GameOfSkateVC) {
        self.game = game
    }
    
    var body: some View {
        VStack {
            headerStack
            playersStack
            Spacer()
            Button("Add Player") {
                game.addPlayer()
            }
            Text("Winnder: \(game.winner()?.name ?? "")")
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
        }
        .sheet(isPresented: $showImagePicker) {
            LettersEditView(game: game)
        }
        .padding(.horizontal, 0.0)
        .ignoresSafeArea(edges: .top)
    }
    
    // MARK: - header stack
    var headerStack: some View {
        HStack {
            Text("Game of \(game.letters)!")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Button(action: {
                showImagePicker = true
            }) {
                Image(systemName: "pencil.circle.fill")
                    .font(.largeTitle)
            }
            .foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.top, 32.0)
        .background(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
    }
    
    // MARK: - player stack
    var playersStack: some View {
        List {
            ForEach(game.players) { player in
                HStack {
                    VStack(alignment: .leading) {
                        Text("Player: \(player.name)")
                        Text("Letters: \(game.lettersOfPlayer(player))")
                    }
                    Spacer()
                    
                    Button("↩") {
                        game.removeLetter(to: player)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(game.lettersOfPlayer(player) == "")
                    
                    Button("Letter!") {
                        game.giveLetter(to: player)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(game.lettersOfPlayer(player) == game.letters)
                }
                .padding(.horizontal)
            }
            .onDelete(perform: { indexSet in
                game.removePlayer(at: indexSet)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameOfSkateView(game: GameOfSkateVC(letters: "skate",
                                            playerNames: ["Skatet 1", "Skater 2", "Skater 3"]))
            .previewDevice("iPhone 12")
    }
}
