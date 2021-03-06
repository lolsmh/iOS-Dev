//
//  ViewController.swift
//  Cards
//
//  Created by Даниил Апальков on 27.01.2021.
//

import UIKit

class ViewController: UIViewController {
    var deck = PlayingCardDeck()
    var theme: UIColor = #colorLiteral(red: 1, green: 0.8940725607, blue: 0.4865207752, alpha: 1)
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale))
            playingCardView.addGestureRecognizer(pinch)
        }
    }

    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    

    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp.toggle()
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme
    }
}

