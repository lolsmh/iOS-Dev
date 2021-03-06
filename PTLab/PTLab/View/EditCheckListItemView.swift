import SwiftUI

struct EditCheckListItemView: View {
    
    @Binding var checkListItem: CheckListItem
    
    var body: some View {
        Form {
            TextField("Задача", text: $checkListItem.name)
            TextField("Описание", text: $checkListItem.description)
            Picker(selection: self.$checkListItem.priority, label: Text("Приоритет"), content: {
                Text("Высокий").tag(Priority.high)
                Text("Средний").tag(Priority.medium)
                Text("Низкий").tag(Priority.low)
            })
            Toggle("Готово", isOn: $checkListItem.isChecked)
//            Section {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(checkListItem.images.indices, id:\.self) { index in
//                            Image(uiImage: checkListItem.images[index].image)
//                                .resizable()
//                                .frame(width: 150, height: 150)
//                                .cornerRadius(15)
//                                .padding(.leading)
//                        }
//                    }
//                }
//            }
        }
        .navigationBarTitle(Text("Редактировать"))
    }
}
