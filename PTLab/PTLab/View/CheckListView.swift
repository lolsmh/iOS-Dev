import SwiftUI
import SwiftlySearch
import LocalAuthentication

struct CheckListView: View {
    @State
    var checklist: CheckList
    @State
    var newItemSheetIsPresented = false
    @State
    var isUnlocked: Bool = false {
        willSet {
            if isUnlocked == false {
                auhenticate()
            }
        }
    }
    @State
    var searchText = ""    
    
    func auhenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        
                    }
                }
            }
        } else {
            
        }
    }
    
    
    var body: some View {
        Group {
            ZStack {
                if self.checklist.items.isEmpty {

                    //MARK: - Empty Check List View
                    VStack {
                        Spacer()
                        Image(systemName: "plus.viewfinder")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding()
                            .foregroundColor(Color(#colorLiteral(red: 0.7311924118, green: 0.7311924118, blue: 0.7311924118, alpha: 1)))
                        Text("Пока пусто")
                            .foregroundColor(Color(#colorLiteral(red: 0.7311924118, green: 0.7311924118, blue: 0.7311924118, alpha: 1)))
                        Spacer()
                    }
                    .offset(y: -30)

                } else {
                    //MARK: - Check List


                        Form {
                            ForEach(checklist.items.indices, id: \.self) { item in
                                RowView(checkListItem: $checklist.items[item], isLocked: $isUnlocked)
                            }
                        }

                        

                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.blue)
                            Button(action: {
                                self.newItemSheetIsPresented = true
                            }, label: {
                                NavigationLink(
                                    destination: NewCheckListItemView(checklist: checklist),
                                    isActive: $newItemSheetIsPresented,
                                    label: {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.white)
                                    })
                            })
                        }
                        .padding(30)
                    }
                }
                .ignoresSafeArea()
            }
        }
        .navigationTitle(self.checklist.name)
        .navigationBarItems(trailing: Menu(content: {
            Button(action: { self.isUnlocked.toggle() }, label: {
                HStack {
                    if isUnlocked {
                        Text("Заблокировать")
                    } else {
                        Text("Разблокировать")
                    }
                    LockView(isUnlocked: isUnlocked).frame(width: 50, height: 50).foregroundColor(.gray)
                }
            })
            .disabled(self.checklist.items.isEmpty)
            EditButton()
        }, label: {Image(systemName: "ellipsis.circle")})
         )
        .navigationBarSearch(self.$searchText, placeholder: "Задачи, даты, описания...")
    }
}

