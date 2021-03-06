
import Foundation
import SwiftUI

class ListsViewModel: ObservableObject {
    @Published var checklists: [CheckList] = [CheckList(name: "Все", imageName: "all-icon")]
    @Published var currentList: CheckList?
    
}
