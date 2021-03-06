import SwiftUI
import LinkPresentation


struct AdditionalSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @Binding var notificationDate: Date
    @Binding var needsToBeLocked: Bool
    @Binding var inputImage: UIImage?
    @Binding var selected: [UIImage]
    @State var data: [Images] = []
    @State var isShowingImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showImagePicker: Bool = false
    @State var isShowingDatePicker: Bool = false
    @State var image: UIImage?
    @State var isShowingLinkModalWindow: Bool = false
    @State var links: [URL?] = []
    @State var link: String = ""
    
    var body: some View {
        Form {
            
            //MARK: -Password Lock Section
            Section {
                Toggle(isOn: self.$needsToBeLocked, label: {
                    Text("Защитить паролем")
                })
                .padding([.leading])
            }
            //MARK: -Notification Section
            Section {
                Toggle(isOn: self.$isShowingDatePicker, label: {
                    Text("Поставить напоминание")
                })
                .padding([.leading])
                if self.isShowingDatePicker {
                    DatePicker("Напомнить", selection: self.$notificationDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .animation(.spring())
                }
            }
            //MARK: -Image Picking Section
            Section {
                HStack {
//                    NavigationLink(
//                        destination: MultyImagePicker(selection: self.$selected)
//                            .ignoresSafeArea(edges: .bottom)
//                            .navigationBarTitle("Добавить фото")
//                            .navigationBarTitleDisplayMode(.inline),
//                        isActive: self.$isShowingImagePicker,
//                        label: {
//                            Text("Прикрепить  фото")
//                        })
//                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    Button(action: {
                        self.isShowingImagePicker = true
                    }, label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Прикрепить  фото")
                            Spacer()
                        }
                    })
                    .actionSheet(isPresented: $isShowingImagePicker) {
                        ActionSheet(title: Text("Выберите опцию"), message: nil, buttons: [
                            .default(Text("Снять фото")) {
                                self.showImagePicker = true
                                self.sourceType = .camera
                            },
                            .default(Text("Выбрать из библиотеки")) {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                            },
                            .cancel()
                        ])
                    }
                }
                //TODO: Multiply Photo Selection
                if !self.selected.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(self.selected, id: \.self) { i in
                                Image(uiImage: i)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .clipped()
                                    .padding(.leading)
                            }
                        }
                    }
                }
                if self.image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipped()
                        .padding(.leading)
                }
            }
            
            Section {
                Button(action: {
                    self.isShowingLinkModalWindow = true
                }, label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Добавить ссылку")
                        Spacer()
                    }
                })
                if isShowingLinkModalWindow {
                    TextField("Pass the link", text: $link)
                    Button("Готово") {
                        self.links.append(URL(string: link))
                        self.link = ""
                        self.isShowingLinkModalWindow = false
                    }
                }
                if !self.links.isEmpty {
                    ForEach(self.links, id: \.self) { url in
                        if url != nil {
                            LinkView(url: url!)
                        }
                    }
                }
            }
        
        }
        .sheet(isPresented: self.$showImagePicker, content: {
            ImagePicker(image: $image, sourceType: sourceType)
                .edgesIgnoringSafeArea(.bottom)
        })
        .animation(.spring())
        .navigationBarTitle("Дополнительно")
    }
}
