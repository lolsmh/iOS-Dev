//
//  ThemeChooserViewController.swift
//  Cards
//
//  Created by Даниил Апальков on 28.01.2021.
//

import UIKit

class ThemeChooserViewController: UIViewController {
    
    let colours: [String : UIColor] = [
        "Yellow" : #colorLiteral(red: 1, green: 0.869874879, blue: 0.3204131218, alpha: 1),
        "Blue" : #colorLiteral(red: 0.3780766641, green: 0.8050723503, blue: 1, alpha: 1),
        "Red" : #colorLiteral(red: 1, green: 0.3304440524, blue: 0.3350054075, alpha: 1)
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = colours[themeName] {
                if let vc = segue.destination as? ViewController {
                    vc.theme = theme
                }
            }
        }
    }
}
