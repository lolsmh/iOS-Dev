import SwiftUI

struct CheckListItem: Codable, Identifiable, Hashable, Comparable {
    static func < (lhs: CheckListItem, rhs: CheckListItem) -> Bool {
        lhs.priority < rhs.priority
    }
    
    static func == (lhs: CheckListItem, rhs: CheckListItem) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID().uuidString
    var name: String
    var isChecked: Bool = false
    var priority: Priority
    var description: String = ""
    var notificationDate: Date?
    var isLocked: Bool = false
    var images: [CodableUIImage]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
