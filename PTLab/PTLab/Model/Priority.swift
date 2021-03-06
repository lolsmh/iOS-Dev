import Foundation

enum Priority: Int, Codable, Comparable{
    static func < (lhs: Priority, rhs: Priority) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case low, medium, high
    
    init(from decoder: Decoder) throws {
        self = Priority(rawValue: try decoder.singleValueContainer().decode(RawValue.self)) ?? .low
    }
}
