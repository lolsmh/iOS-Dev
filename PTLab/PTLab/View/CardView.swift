import SwiftUI

//TODO: Change View
struct CardView: View {
    @State var data: Images
    @Binding var selected: [UIImage]

    var body: some View {
        
        ZStack {
            
            Image(uiImage: self.data.image)
                .resizable()
                .cornerRadius(3)
            
            if self.data.selected {
                ZStack {
                    Color.black.opacity(0.5)
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
        }
        .frame(width: (UIScreen.main.bounds.width - 80) / 3, height: 90)
        .onTapGesture {
            if !self.data.selected {
                self.data.selected = true
                self.selected.append(self.data.image)
            }
            else {
                for i in 0..<self.selected.count {
                    if self.selected[i] == self.data.image {
                        self.selected.remove(at: i)
                        self.data.selected = false
                        return
                    }
                }
            }
        }
    }
}
