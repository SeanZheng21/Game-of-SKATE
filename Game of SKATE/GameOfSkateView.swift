//
//  ContentView.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/3/21.
//

import SwiftUI

struct GameOfSkateView: View {
    @ObservedObject var game: GameOfSkateVC
    
    init(game: GameOfSkateVC) {
        self.game = game
    }
    
    var body: some View {
        VStack {
            Text("Game of \(game.letters)!")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
                .padding()
            playersStack
            Spacer()
            Button("Add Player") {
                game.addPlayer()
            }
            Text("Winnder: \(game.winner()?.name ?? "")")
        }
    }
    
    var playersStack: some View {
//        List {
            ForEach(game.players) { player in
                HStack {
                    VStack(alignment: .leading) {
                        Text("Player: \(player.name)")
                        Text("Letters: \(game.lettersOfPlayer(player))")
                    }
                    Spacer()
                    Button("X") {
                        game.removePlayer(player)
                    }
                    Button("↩") {
                        game.removeLetter(to: player)
                    }
                    Button("Letter!") {
                        game.giveLetter(to: player)
                    }
                    
                }
                .padding(.horizontal)
            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameOfSkateView(game: GameOfSkateVC(letters: "sk8",
                                            playerNames: ["Skatet 1", "Skater 2", "Skater 3"]))
            .previewDevice("iPhone 12")
    }
}
