//
//  EmojieMemoryGameView.swift
//  Memorize
//
//  Created by Даниил Апальков on 28.11.2020.
//

import SwiftUI

struct EmojieMemoryGameView: View {
    @ObservedObject var viewModel = EmojieMemoryGame()
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(Animation.easeInOut(duration: 0.4)) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(.black)
            Button(action: {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }, label: {Text("Новая игра")})
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90), clockwise: true)
                                .onAppear {
                                    self.startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90), clockwise: true)
                        }
                    }
                    .padding(5).opacity(0.40).foregroundColor(.red)
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(.spring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.5))
                }
                .cardify(isFaceUp: card.isFaceUp)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .font(Font.system(size: fontSize(for: geometry.size)))
                .transition(AnyTransition.scale)
            }
        }
    }
    
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojieMemoryGame()
        game.choose(card: game.cards[0])
        return EmojieMemoryGameView(viewModel: game)
    }
}
