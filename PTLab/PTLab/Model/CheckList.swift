//
//  CheckList.swift
//  PTLab
//
//  Created by Даниил Апальков on 03.03.2021.
//

import Foundation
import SwiftUI

struct CheckList: Hashable, Identifiable {
    var id: String = UUID().uuidString
    private(set) var imageName: String
    private(set) var name: String
//    private(set) var backgroundColor: (Int, Int, Int)
//    private(set) var textForegroundColor: (Int, Int, Int)
//    private(set) var backgroundImage: String?
    var items: [CheckListItem] = []
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    mutating func add(_ item: CheckListItem) {
        self.items.append(item)
    }
    
    mutating func remove(_ item: CheckListItem) {
        self.items.removeAll { $0 == item }
    }
    
    mutating func move(at index: IndexSet, destanation: Int) {
        items.move(fromOffsets: index, toOffset: destanation)
    }
    
    mutating func sort() {
        self.items.sort(by: >)
    }
    
    func save() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode([self.items])
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    mutating func load() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                let items = try decoder.decode([CheckListItem].self, from: data)
                self.items = items
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("CheckList.plist")
    }
}
