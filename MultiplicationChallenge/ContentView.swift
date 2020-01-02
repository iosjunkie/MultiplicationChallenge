//
//  ContentView.swift
//  Challenge2
//
//  Created by Ale Mohamad on 30/10/2019.
//  Copyright © 2019 Ale Mohamad. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let blueColor = Color(red: 88/255, green: 133/255, blue: 238/255)
    
    var gameStatus: Bool {
        get {
            return correctAnswers > questions.count / 2
        }
    }
    
    @State private var questions = [Question]()
    
    @State private var section = 1
    
    @State private var currentQuestion = 0
    @State private var correctAnswers = 0
    @State private var shakeAnimal = false
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack {
                Spacer()
            }
            
            if section == 1 {
                SettingsView { multiplication, totalQuestions in
                    self.createQuestions(tableFamily: multiplication, totalQuestions: totalQuestions)
                }
                .transition(AnyTransition.opacity.combined(with: .scale))
            } else if section == 2 {
                Group {
                    VStack(alignment: .center) {
                        bigSpace()
                        Image("character_\(questions[currentQuestion].multiplicationFamily)")
                        .offset(x: shakeAnimal ? -10 : 0)
                        .animation(Animation.linear(duration: 0.1).repeatCount(shakeAnimal ? 5 : 0))
                        .overlay(
                            Rectangle()
                                .stroke(Color.white)
                                .scaleEffect(animationAmount)
                                .opacity(Double(1.4 - animationAmount))
                                .animation(
                                    Animation.easeOut(duration: 1)
                                        .repeatForever(autoreverses: false)
                                )
                        )
                        .onAppear {
                            self.animationAmount = 1.4
                        }
                        
                        Text("What is \(questions[currentQuestion].multiplicationFamily) ⨉ \(questions[currentQuestion].multiplier)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Group {
                            HStack(spacing: 50.0) {
                                Button(action: {
                                    self.checkAnswer(self.questions[self.currentQuestion].first)
                                }) {
                                    NumbersView(numbers: "\(questions[currentQuestion].first)")
                                }
                                Button(action: {
                                    self.checkAnswer(self.questions[self.currentQuestion].second)
                                }) {
                                    NumbersView(numbers: "\(questions[currentQuestion].second)")
                                }
                            }
                        }
                        bigSpace()
                        HStack(alignment: .bottom) {
                            Text("\(currentQuestion + 1)")
                            Spacer()
                            Text("of")
                            Spacer()
                            Text("\(questions.count)")
                        }
                        .padding(10)
                        .foregroundColor(Color.gray)
                        .background(Color.white)   
                    }
                }
            } else if section == 3 {
                Group {
                    bigSpace()
                    Text("Game over")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Image(gameStatus ? "player_happy" : "player_sad")
                    Text(gameStatus ? "Yes! You made \(correctAnswers) correct anwers." : "Oops! You only made \(correctAnswers) correct anwers.\nKeep practicing!")
                        .font(.headline)
                        .padding(.bottom, 24.0)
                    
                    Button(action: {
                        withAnimation {
                            self.replay()
                        }
                    }) {
                        Text("Let's play again...")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    bigSpace()
                }
                .transition(.asymmetric(insertion: .scale, removal: .scale))
            }
        }
        .padding(section == 2 ? 0 : 24.0)
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: [blueColor, .purple]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
    
    func createQuestions(tableFamily: Int, totalQuestions: Int) {
        let values = [Int](0..<totalQuestions).shuffled()
        
        questions.removeAll(keepingCapacity: true)
        
        for value in values {
            questions.append(Question(family: tableFamily, multiplier: value))
        }
        
        currentQuestion = 0
        section = 2
    }
    
    func checkAnswer(_ chosen: Int) {
        if chosen == questions[currentQuestion].correct {
            correctAnswers += 1
        } else {
            shakeAnimal = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.shakeAnimal.toggle()
            }
        }
        
        currentQuestion += 1
        
        if currentQuestion == questions.count {
            gameOver()
            animationAmount = 1
        }
    }
    
    func gameOver() {
        section = 3
    }
    
    func replay() {
        correctAnswers = 0
        section = 1
    }
    
    func bigSpace() -> some View {
        Group {
            Spacer()
            HStack {
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
