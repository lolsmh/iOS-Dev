//
//  Array+Identifable.swift
//  Memorize
//
//  Created by Даниил Апальков on 30.11.2020.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
