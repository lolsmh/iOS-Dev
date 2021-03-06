//
//  Array+Only.swift
//  Memorize
//
//  Created by Даниил Апальков on 01.12.2020.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
