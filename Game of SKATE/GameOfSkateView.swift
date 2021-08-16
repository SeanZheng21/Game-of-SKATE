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
            if game.hasWinner() {
                WinnerView(game: game)
            } else {
                headerStack
                playersStack
            }
            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            LettersEditView(game: game)
        }
        .padding(.horizontal, 0.0)
        .ignoresSafeArea(edges: .bottom)
        .ignoresSafeArea(edges: .top)
        
    }
    
    // MARK: - header stack
    var headerStack: some View {
        HStack (spacing: 0) {
            Text("Game of \(game.letters)")
                .font(game.letters.count > 9 ? .title2 : .title)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                showImagePicker = true
            }) {
                Image(systemName: "pencil.circle.fill")
                    .font(.largeTitle)
            }
            .padding(.trailing)
            .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                game.addPlayer()
            }) {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .font(.largeTitle)
            }
            .foregroundColor(.white)
            
            Button(action: {
                game.restartGame()
            }) {
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .font(.largeTitle)
            }
            .foregroundColor(.white)
        }
        .padding(.leading, 7.0)
        .padding(.trailing)
        .padding(.top, 35.0)
        .background(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
    }
    
    // MARK: - player stack
    var playersStack: some View {
        List {
            ForEach(game.players) { player in
                PlayerCellView(player, game)
            }
            .onDelete(perform: { indexSet in
                game.removePlayer(at: indexSet)
            })
        }
    }
}

enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameOfSkateView(game: GameOfSkateVC(letters: "SKATE",
                                            playerNames: ["Skater 1", "Skater 2", "Skater 3"]))
            .previewDevice("iPhone 12")
    }
}
