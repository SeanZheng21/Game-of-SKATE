//
//  GameModel.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/14/21.
//

import Foundation

struct GameModel {
    private(set) var letters: String
    private(set) var players: [Player]
    
    init(letters: String="SKATE", playerNames: [String]=["Skater 1", "Skater 2"]) {
        self.letters = letters.uppercased()
        self.players = []
        for playerIdx in 0..<playerNames.count {
            self.players.append(Player(id: playerIdx, name: playerNames[playerIdx]))
        }
    }
    
    func lettersOfPlayer(_ player: Player) -> String {
        let firstMatchedPlayer = players.first(where: {$0.id == player.id})
        return lettersOfCount(firstMatchedPlayer?.letterCount ?? -1)
    }
    
    func lettersOfCount(_ count: Int) -> String {
        if count < 0 || count > letters.count {
            return "ERROR"
        } else {
            return String(letters.prefix(count))
        }
    }
    
    func playerExists(name: String) -> Bool {
        return players.contains(where: { $0.name == name })
    }
    
    mutating func giveLetter(to player: Player) {
        for playerIdx in players.indices {
            if players[playerIdx].id == player.id {
                players[playerIdx].giveLetter()
            }
        }
    }
    
    mutating func removeLetter(from player: Player) {
        for playerIdx in players.indices {
            if players[playerIdx].id == player.id {
                players[playerIdx].removeLetter()
            }
        }
    }
    
    mutating func removePlayer(_ player: Player)  {
        players.removeAll(where: {$0.id == player.id})
        for playerIdx in players.indices {
            if players[playerIdx].id > player.id {
                players[playerIdx].id -= 1
            }
        }
        if players.count == 0 {
            addPlayer("Skater 1")
            addPlayer("Skater 2")
        }
    }
    
    mutating func addPlayer(_ playerName: String="")  {
        var incr = 1
        // Find an inexisting name for the new player
        while playerExists(name: "Skater \(players.count + incr)") {
            incr += 1
        }
        let nameToAdd = playerName == "" ? "Skater \(players.count + incr)" : playerName
        players.append(Player(id: players.count, name: nameToAdd))
    }
    
    func winner() -> Player? {
        let leftPlayers = players.filter({$0.letterCount < letters.count})
        if leftPlayers.count == 1 {
            return leftPlayers[0]
        } else {
            return nil
        }
    }
    
    mutating func setLetters(to newLetters: String) {
        if newLetters.count > 16 || newLetters.count < 3 {
            return
        }
        letters = newLetters.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        for playerIdx in players.indices {
            if players[playerIdx].letterCount > newLetters.count {
                players[playerIdx].resetLetterCount(to: newLetters.count)
            }
        }
    }
    
    mutating func restartGame() {
        for playerIdx in players.indices {
            players[playerIdx].resetLetterCount()
        }
    }
    
    mutating func renamePlayer(_ player: Player, to newName: String) {
        for playerIdx in players.indices {
            if players[playerIdx].id == player.id {
                players[playerIdx].renamePlayer(to: newName)
            }
        }
    }
    
    // MARK: - Static methods
    static func getLettersOptions() -> [String] {
        ["SK8",
        "SKATE",
        "SKATER",
        "SKATERS",
        "SKATEBOARD",
        "SKATEBOARDING"]
    }
    
    // MARK: - Player Struct
        struct Player: Identifiable {
            var id: Int
            
            private(set) var name: String
            private(set) var letterCount: Int
            
            init(id: Int, name: String, letterCount: Int=0) {
                self.id = id
                self.name = name
                self.letterCount = letterCount
            }
            
            mutating func giveLetter() {
                self.letterCount += 1
            }
            
            mutating func removeLetter() {
                if self.letterCount >= 1 {
                    self.letterCount -= 1
                }
            }
            
            mutating func resetLetterCount(to letterCount: Int=0) {
                self.letterCount = letterCount
            }
            
            mutating func renamePlayer(to newName: String) {
                name = newName
            }
    }
}
