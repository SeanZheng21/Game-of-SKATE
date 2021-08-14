//
//  GameOfSkateVC.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/14/21.
//

import Foundation

class GameOfSkateVC: ObservableObject {
    typealias Player = GameModel.Player
    
    @Published private var gameModel: GameModel
    
    var letters: String {
        gameModel.letters
    }
    
    var players: [Player] {
        gameModel.players
    }
    
//    var game: GameModel {
//        gameModel
//    }
    
    init(game: GameModel) {
        self.gameModel = game
    }
    
    init(letters: String, playerNames: [String]) {
        self.gameModel = GameModel(letters: letters, playerNames: playerNames)
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
    
    func removeLetter(to player: Player) {
        gameModel.removeLetter(from: player)
    }
    
    func winner() -> Player? {
        return gameModel.winner()
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
}
