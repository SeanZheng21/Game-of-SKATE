//
//  GameOfSkateVC.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/14/21.
//

import Foundation
import SwiftUI

class GameOfSkateVC: ObservableObject {
    typealias Player = GameModel.Player
    
    @Published private var gameModel: GameModel
    
    var letters: String {
        gameModel.letters
    }
    
    var players: [Player] {
        gameModel.players
    }
    
    init(game: GameModel) {
        self.gameModel = game
    }
    
    init(letters: String, playerNames: [String]) {
        self.gameModel = GameModel(letters: letters, playerNames: playerNames)
    }
    
    func letterTuplesOfPlayer(_ player: Player) -> [IdentifiableString] {
        let characters = gameModel.lettersOfPlayer(player).map({ String($0) })
        var stringTuples = [IdentifiableString]()
        for idx in 0..<gameModel.letters.count {
            stringTuples.append(IdentifiableString(id: idx, str: " "))
        }
        for strIdx in characters.indices {
            stringTuples[strIdx] = IdentifiableString(id: strIdx, str: characters[strIdx])
        }
        return stringTuples
    }
    
    func lettersOfPlayer(_ player: Player) -> String {
        return gameModel.lettersOfPlayer(player)
    }
    
    func lettersOfCount(_ count: Int) -> String {
        return gameModel.lettersOfCount(count)
    }
    
    func giveLetter(to player: Player) {
        gameModel.giveLetter(to: player)
    }
    
    func removeLetter(from player: Player) {
        gameModel.removeLetter(from: player)
    }
    
    func winner() -> Player? {
        return gameModel.winner()
    }
    
    func hasWinner() -> Bool {
        return gameModel.winner() != nil
    }
    
    func removePlayer(at indexSet: IndexSet) {
        for index in indexSet {
            let player = players[index]
            gameModel.removePlayer(player)
        }
    }
    
    func removePlayer(_ player: Player) {
        gameModel.removePlayer(player)
    }
    
    func addPlayer(_ playerName: String="") {
        gameModel.addPlayer(playerName)
    }
    
    func setLetters(to newLetters: String) {
        gameModel.setLetters(to: newLetters)
    }
    
    func restartGame() {
        gameModel.restartGame()
    }
    
    func renamePlayer(_ player: Player, to newName: String) {
        gameModel.renamePlayer(player, to: newName)
    }
    
    func aspectRatioForCell() -> CGFloat {
        if gameModel.letters.count <= 5 {
            return 2 / 3         // One Row
        } else if gameModel.letters.count <= 10 {
            return 4 / 5         // Two Rows
        } else {
            return 6 / 7             // Three Rows
        }
    }
    
    func heightForCell() -> CGFloat {
        if gameModel.letters.count <= 5 {
            return 150         // One Row
        } else if gameModel.letters.count <= 10 {
            return 220         // Two Rows
        } else {
            return 280             // Three Rows
        }
    }
    
    struct IdentifiableString: Identifiable {
        let id: Int
        let str: String
    }
}
