//
//  WinnerView.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/16/21.
//

import SwiftUI
import AVKit

struct WinnerView: View {
    @ObservedObject var game: GameOfSkateVC
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("ConfettiFour")
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(height: 400.0)
            
            }
            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    Image("ConfettiOne")
                        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                        .frame(height: 250.0)
                    Image("ConfettiTwo")
                        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                        .frame(width: 100.0, height: 100.0)
                }
            
            }
            
            VStack {
                Image("ConfettiFour")
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(height: 400.0)
                Spacer()
            }
            
            VStack {
                Spacer()
                ZStack {
                    Image("congrats")
                        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                        .frame(height: 300.0)
                    VStack {
                        ZStack {
                            Capsule()
                                .fill(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.746201572)))
                                .frame(width: 350, height: 100)
                                .shadow(color: .red, radius: 20, x: 5.0, y: 5.0)
                           Text(game.winner()?.name ?? "")
                                .font(.system(size: 60.0))
                                .fontWeight(.bold)
                                .foregroundColor(Color.yellow)
                                .shadow(color: .red, radius: 5, x: 5.0, y: 5.0)
                        }
                        .padding(.top, 200.0)
                    }
                }
                HStack {
                    Spacer()

                    Button (action: {
                        withAnimation {
                            game.restartGame()
                        }
                    }, label: {
                        Text("RESTART")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 18.0)
                            .padding(.vertical, 8.0)
                            .multilineTextAlignment(.center)
                    })
                    .buttonStyle(GradientButtonStyle(isEnabled: true))
                    Spacer()
                }
                Spacer()
            }
            Spacer()
        }
            .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.3029856903)))
            .ignoresSafeArea(edges: .all)
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(game: GameOfSkateVC(letters: "SKATE",
                                 playerNames: ["Skater 1", "Skater 2", "Skater 3"]))
    }
}
