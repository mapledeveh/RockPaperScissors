//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alex Nguyen on 2023-05-06.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State private var gameCount = 1
    @State private var score = 0
    @State private var playerMove = 3
    @State private var playerAnswer = ""
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    let answers: [(String, String)] = [ ("✊🏻","Rock"), ("✋🏻","Paper"), ("✌🏻","Scissors"), ("❓", "")]
    let beating: [String: String] = [ "Rock": "Paper", "Paper": "Scissors", "Scissors": "Rock" ]
        
    func playerPlay(_ answer: Int) {
        
        let evaluate = { (answer: Bool) in
            if answer {
                score += 1
                playerAnswer = "Correct"
            } else {
                playerAnswer = "Wrong"
            }
        }
        
        let player = answers[playerMove].1
        let machine = answers[appMove].1
                
        shouldWin ? evaluate(player == beating[machine]) : evaluate(machine == beating[player])
//        if shouldWin {
//            evaluate(player == beating[machine])
//            switch answers[appMove].1 {
//            case "Rock":
//                evaluate(answers[playerMove].1 == "Paper")
//            case "Paper":
//                evaluate(answers[playerMove].1 == "Scissors")
//            case "Scissors":
//                evaluate(answers[playerMove].1 == "Rock")
//            default: break
//            }
//        } else {
//            evaluate(player != beating[machine])
//            switch appMove {
//            case 0:
//                evaluate(playerMove == 2)
//            case 1:
//                evaluate(playerMove == 0)
//            case 2:
//                evaluate(playerMove == 1)
//            default: break
//            }
//        }
    }
    
    func movingOn() {
        if gameCount == 10 {
            gameCount = 1
            score = 0
        } else {
            gameCount += 1
        }
        
        appMove = Int.random(in: 0...2)
        shouldWin.toggle()
        playerMove = 3
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [.red, .yellow, .white, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Round \(gameCount)")
                    .font(.largeTitle)
                                
                Text("Computer decides player")
                    .font(.headline)
                
                Text("\(shouldWin ? "WIN" : "LOSE")")
                    .padding()
                    .foregroundColor(shouldWin ? .red : .white)
                    .font(.system(size: 100))
                    .fontWeight(.bold)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 10)
                
                HStack(spacing: 50) {
                    VStack {
                        Text("Computer's Move:")
                        Text(answers[appMove].0)
                            .font(.system(size: 100))
                            .frame(height: 100)
                    }
                    
                    VStack {
                        Text("Player's Move:")
                        Text(answers[playerMove].0)
                            .font(.system(size: 100))
                            .frame(height: 100)
                    }
                }
                
                HStack {
                    
                    ForEach(0..<3) { number in
                        Button {
                            playerMove = number
                        } label: {
                            VStack {
                                Text(answers[number].0)
                                    .font(.largeTitle)
                                Text(answers[number].1)
                                    .foregroundColor(.white)
                            }
                            .padding(5)
                            .frame(minWidth: 80, minHeight: 80)
                            .background(.teal)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding()
                                
                HStack {
                    Button("Skip", role: .cancel, action: movingOn)
                        .buttonStyle(.bordered)
                    
                    Button("Submit") {
                        playerPlay(playerMove)
                        showAlert = true
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .alert("\(playerAnswer)!", isPresented: $showAlert) {
                    Button("Continue") {
                        movingOn()
                    }
                } message: {
                    if gameCount == 10 {
                        Text("You've finished 10 rounds of the game. Your score is \(score).")
                    } else {
                        Text("You're set to \(shouldWin ? "win" : "lose") this game.")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
