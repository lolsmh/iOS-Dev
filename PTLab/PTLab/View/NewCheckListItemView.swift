import SwiftUI
import LinkPresentation

struct NewCheckListItemView: View {
    
    private var checklist: CheckList
    @State var newItemName = ""
    @State var description = ""
    @State var priority: Priority = .low
    @State var notificationDate: Date = Date().addingTimeInterval(-100)
    @State var inputImage: UIImage?
    @State var selected: [UIImage] = []
    @State var needsToBeLocked: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    init(checklist: CheckList) {
        self.checklist = checklist
    }
    
    func addNotification(for item: CheckListItem, in date: Date) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            
            content.title = "Не забудь \(item.name.lowercased())!"
            content.subtitle = "\(item.description)"
            content.sound = .default
            let components = Calendar.current.dateComponents([.hour, .minute], from: date)
            
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { setting in
            if setting.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    }
                }
            }
        }
    }
    
    var body: some View {
        Form {
            //MARK: -Base Task Settings Section
            Section {
                TextField("Задача", text: $newItemName)
                TextField("Описание", text: $description)
                VStack(alignment: .leading, spacing: nil) {
                    Text("Приоритет")
                    Picker(selection: self.$priority, label: Text("Приоритет"), content: {
                        Text("Низкий").tag(Priority.low)
                        Text("Средний").tag(Priority.medium)
                        Text("Высокий").tag(Priority.high)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding([.top, .bottom], 3)
            }
            //MARK: -Advanced Task Settings Section
            Section {
                NavigationLink("Дополнительно", destination: AdditionalSettingsView(notificationDate: $notificationDate, needsToBeLocked: self.$needsToBeLocked, inputImage: $inputImage, selected: self.$selected))
            }
            
            //MARK: -Accept Button
            Section {
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "checkmark")
                        Text("Готово")
                    }
                }
                .disabled(newItemName.count == 0)
            }
        }
        .navigationBarTitle("Новая задача")
    }
}

