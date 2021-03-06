import SwiftUI

struct RowView: View {
    
    @Binding var checkListItem: CheckListItem
    @Binding var isLocked: Bool
    
    var body: some View {
        NavigationLink(destination: EditCheckListItemView(checkListItem: self.$checkListItem)) {
            HStack {
                Image(systemName: checkListItem.isChecked ? "checkmark.circle.fill" : "checkmark.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            checkListItem.isChecked.toggle()
                        }
                    }
                    .animation(.spring())
                Text(checkListItem.isLocked && !isLocked ? "Заблокированно" : checkListItem.name).strikethrough(checkListItem.isChecked, color: .black)
                Spacer()
                if checkListItem.isLocked {
                    Image(systemName: isLocked ? "lock.open" : "lock")
                }
            }
            .animation(.linear)
        }
        .disabled(checkListItem.isLocked ? (isLocked ? false : true) : false)
    }
}
