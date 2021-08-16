//
//  PlayerNameEditView.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/16/21.
//

import SwiftUI

struct PlayerNameEditView: View {
    typealias Player = GameModel.Player
    
    @Binding private var showPlayerNameEditor: Bool
    @ObservedObject private var game: GameOfSkateVC
    private var player: Player
    @State private var playerName: String
    
    init(_ showPlayerNameEditor: Binding<Bool>, _ game: GameOfSkateVC, _ player: Player) {
        self._showPlayerNameEditor = showPlayerNameEditor
        self.game = game
        self.player = player
        self.playerName = player.name
    }
    
    var body: some View {
        ZStack {
                Color.white
                VStack {
                    if (showPlayerNameEditor) {
                        Text("Edit Skater Name")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                    }
                    Spacer()
                    
                    ZStack {
                        TextField(game.letters, text: $playerName, onEditingChanged: { began in
                            if !began {
                                game.renamePlayer(player, to: playerName)
                                withAnimation {
                                    self.showPlayerNameEditor = false
                                }
                            }
                        })
                            .autocapitalization(.words)
                            .disableAutocorrection(false)
                            .padding(.all)
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
                    
                    Button(action: {
                        game.renamePlayer(player, to: playerName)
                        withAnimation {
                            self.showPlayerNameEditor = false
                        }
                    }, label: {
                        Text("Close")
                    })
                }.padding()
            }
            .frame(width: 300, height: 150)
            .cornerRadius(20).shadow(radius: 20)
    }
}

struct PlayerNameEditView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerNameEditView(.constant(true), GameOfSkateVC(letters: "SKATE",
                                                          playerNames: ["Skatet 1", "Skater 2", "Skater 3"]), GameModel.Player(id: 1, name: "Skater 2"))
    }
}



//struct CustomTextField: UIViewRepresentable {
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//
//        @Binding var text: String
//        var didBecomeFirstResponder = false
//
//        init(placeholder: String?, text: Binding<String>) {
//
//            _text = text
//        }
//
//        func textFieldDidChangeSelection(_ textField: UITextField) {
//            text = textField.text ?? ""
//        }
//
//    }
//
//    @Binding var text: String
//    var isFirstResponder: Bool = false
//
//    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
//        let textField = UITextField(frame: .zero)
//        textField.delegate = context.coordinator
//        return textField
//    }
//
//    func makeCoordinator() -> CustomTextField.Coordinator {
//        return Coordinator(text: $text)
//    }
//
//    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
//        uiView.text = text
//        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
//            uiView.becomeFirstResponder()
//            context.coordinator.didBecomeFirstResponder = true
//        }
//    }
//}
