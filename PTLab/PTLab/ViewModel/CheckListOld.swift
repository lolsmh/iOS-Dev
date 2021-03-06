import Foundation

class CheckListOld : ObservableObject {
    
    @Published var LPItems: [CheckListItem] = []
    @Published var MPItems: [CheckListItem] = []
    @Published var HPItems: [CheckListItem] = []
    
    init() {
        loadListItems()
    }
    
    func deleteLPListItem(at index: IndexSet) {
        LPItems.remove(atOffsets: index)
        saveListItems()
    }
    func deleteMPListItem(at index: IndexSet) {
        MPItems.remove(atOffsets: index)
        saveListItems()
    }
    func deleteHPListItem(at index: IndexSet) {
        HPItems.remove(atOffsets: index)
        saveListItems()
    }
    
    func moveLPListItem(at index: IndexSet, destanation: Int) {
        LPItems.move(fromOffsets: index, toOffset: destanation)
        saveListItems()
    }
    func moveMPListItem(at index: IndexSet, destanation: Int) {
        MPItems.move(fromOffsets: index, toOffset: destanation)
        saveListItems()
    }
    func moveHPListItem(at index: IndexSet, destanation: Int) {
        HPItems.move(fromOffsets: index, toOffset: destanation)
        saveListItems()
    }
    
    func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("CheckList.plist")
    }
    
    func saveListItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode([LPItems, MPItems, HPItems])
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadListItems() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                let items = try decoder.decode([[CheckListItem]].self, from: data)
                self.LPItems = items[0]
                self.MPItems = items[1]
                self.HPItems = items[2]
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
