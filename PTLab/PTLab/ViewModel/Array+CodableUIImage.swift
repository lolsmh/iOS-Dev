
import SwiftUI

extension Array where Element == UIImage {
    var codable: [CodableUIImage] {
        var array = [CodableUIImage]()
        for i in self {
            array.append(CodableUIImage(image: i))
        }
        return array
    }
}
