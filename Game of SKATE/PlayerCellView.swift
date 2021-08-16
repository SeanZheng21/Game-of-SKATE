//
//  PlayerCellView.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/15/21.
//

import SwiftUI

struct PlayerCellView: View {
    typealias Player = GameModel.Player
    
    private var player: Player
    @ObservedObject private var game: GameOfSkateVC
    
    init(_ player: Player, _ game: GameOfSkateVC) {
        self.player = player
        self.game = game
    }
    
    var body: some View {
        let canGiveLetter = game.lettersOfPlayer(player) != ""
        let canRemove = game.lettersOfPlayer(player) != game.letters
        return VStack (alignment: .leading) {
            HStack (alignment: .top) {
                Text(player.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                    .lineLimit(2)
                Spacer()
                
                Button (action: {
                    withAnimation {
                        game.removeLetter(from: player)
                    }
                }, label: {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .foregroundColor(game.lettersOfPlayer(player) != "" ? Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)) : Color(#colorLiteral(red: 0.7421531115, green: 0.6027904466, blue: 1, alpha: 1)))
                        .frame(width: 43.0, height: 43.0)
                        .font(.title)
                })
                .buttonStyle(GradientButtonStyle(isEnabled: canGiveLetter))
                .disabled(!canGiveLetter)
                
                Button (action: {
                    withAnimation {
                        game.giveLetter(to: player)
                    }
                }, label: {
                    Text("LETTER")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 18.0)
                        .padding(.vertical, 8.0)
                        .multilineTextAlignment(.center)
                })
                .buttonStyle(GradientButtonStyle(isEnabled: canRemove))
                .disabled(!canRemove)
            }
            Spacer()
            letterStack
            Spacer()
        }
        .padding(.all)
        .frame(height: game.heightForCell())
    }
    
    // MARK: - Letter Stack
    var letterStack: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50, maximum: 60)),
                         GridItem(.adaptive(minimum: 50, maximum: 60)),
                         GridItem(.adaptive(minimum: 50, maximum: 60)),
                         GridItem(.adaptive(minimum: 50, maximum: 60)),
                         GridItem(.adaptive(minimum: 50, maximum: 60))]) {

            ForEach (game.letterTuplesOfPlayer(player)) { letter in
                Text(letter.str.uppercased())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(#colorLiteral(red: 0.4941176471, green: 0.2274509804, blue: 0.4901960784, alpha: 1)))
                    .cardify(isFaceUp: letter.str != " ")
                    .aspectRatio(game.aspectRatioForCell(), contentMode: .fit)
            }
        }.onTapGesture {
            withAnimation {
                game.giveLetter(to: player)
            }
        }
    }
}

struct GradientButtonStyle: ButtonStyle {
    private var isEnabled: Bool
    
    init(isEnabled: Bool=true) {
        self.isEnabled = isEnabled
    }
    
    private var gradientColors: [Color] {
        if isEnabled {
            return [Color.blue, Color.purple]
        } else {
            return [Color((#colorLiteral(red: 0.6977864066, green: 0.747899632, blue: 1, alpha: 1))), Color((#colorLiteral(red: 1, green: 0.8533701947, blue: 0.9595787637, alpha: 1)))]
        }
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.pink : Color.white)

            .background(LinearGradient(gradient:
                                    Gradient(colors: gradientColors),
                                       startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.4 : 1.0)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
    }
}

struct PlayerCellView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCellView(GameModel.Player(id: 1, name: "Skater 1", letterCount: 3),
                       GameOfSkateVC(letters: "SKATE",
                                     playerNames: ["Skatet 1", "Skater 2", "Skater 3"]))
            .frame(height: 150)
            .background(Color.gray)
    }
}
