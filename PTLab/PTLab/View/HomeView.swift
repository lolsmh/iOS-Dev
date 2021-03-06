//
//  HomeView.swift
//  PTLab
//
//  Created by Даниил Апальков on 03.03.2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var lists = ListsViewModel()
    @State var newListViewIsPresented = false
    @State var searchText = ""
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                
                ], alignment: .center, spacing: 30){
                    ForEach(lists.checklists, id: \.self) { list in
                        ListCardView(title: list.name, imageTitle: list.imageName, checklist: list)
                            .frame(width: 170, height: 120)
                            .contextMenu {
                                Button (action: {
                                    withAnimation(.linear) {
                                        lists.checklists.removeAll { $0 == list }
                                    }
                                }, label: {
                                    HStack {
                                        Text("Удалить")
                                        Image(systemName: "trash")
                                    }
                                })
                                .foregroundColor(.red)
                                Button (action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    HStack {
                                        Text("Редактировать")
                                        Image(systemName: "pencil")
                                    }
                                })
                            }
                            .onDrag {
                                lists.currentList = list
                                return NSItemProvider(contentsOf: URL(string: "\(list.id)")!)!
                            }
                            .onDrop(of: [.url], delegate: DropViewDelegate(list: list, viewModel: lists))
                    }
                }
                .padding()
                .navigationTitle("Органайзер")
                .navigationBarItems(leading: Button(action: {self.newListViewIsPresented = true}, label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Новый список")
                    }
                }))
                .navigationBarSearch($searchText, placeholder: "Поиск")
                .sheet(isPresented: $newListViewIsPresented, content: {
                    NewListItemView(viewModel: lists)
                })
            }
        }
    }
}

struct DropViewDelegate: DropDelegate {
    var list: CheckList
    var viewModel: ListsViewModel
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        let fromIndex = viewModel.checklists.firstIndex { list in
            return list.id == viewModel.currentList?.id
        } ?? 0
        let toIndex = viewModel.checklists.firstIndex { list in
            return list.id == self.list.id
        } ?? 0
        
        if fromIndex != toIndex {
            withAnimation(.default) {
                let fromList = viewModel.checklists[fromIndex]
                viewModel.checklists[fromIndex] = viewModel.checklists[toIndex]
                viewModel.checklists[toIndex] = fromList
            }
        }
    }
}

struct NewListItemView: View {
    @State var image: UIImage?
    @State var isShowingImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var title = "Название"
    @State var pickedImage = "all-icon"
    @State var pickedColor: Color = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    @State var isShowingImageAlertSheet: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @State var textForegroundColor: Color = .gray
    var columns = [GridItem](repeating: .init(.flexible()), count: 5)
    
    @ObservedObject var viewModel: ListsViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    TestListCardView(title: $title, imageTitle: $pickedImage, backgroundColor: $pickedColor, textForegroundColor: $textForegroundColor, image: $image)
                        .frame(width: 200, height: 150)
                        .padding()
                    if image != nil || pickedColor != Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) {
                        ZStack {
//                            Circle()
//                                .foregroundColor(Color.gray)
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                        }
                        .transition(.scale)
                        .frame(width: 30, height: 30)
                        .offset(x: 100 - 5, y: -75 + 5)
                        .onTapGesture {
                            if image != nil {
                                self.image = nil
                                textForegroundColor = .gray
                            } else {
                                pickedColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                                textForegroundColor = .gray
                            }
                        }
                    }
                }
                
                Divider()
                    .padding()
                
                //MARK: - Title Text Field
                HStack {
                    TextField("Название", text: $title)
                        .padding(.leading, 12)
                }
                .frame(width: 340, height: 20)
                .padding()
                .background(colorScheme == .light ? Color(#colorLiteral(red: 0.9344686643, green: 0.9344686643, blue: 0.9344686643, alpha: 1)) : Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                .cornerRadius(25)
                
                
                LazyVGrid(columns: columns) {
                    
                    ColorCircle(color: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), pickedColor: $pickedColor)
                    ColorCircle(color: Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)), pickedColor: $pickedColor)
                    ColorCircle(color: Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)), pickedColor: $pickedColor)
                    
                    //MARK: - Gradient
                    NavigationLink(
                        destination: ColorPickerForListView(title: title, pickedImage: pickedImage,
                                                            pickedColor: $pickedColor, textForegroundColor: $textForegroundColor),
                        label:
                                    {
                                        LinearGradient(gradient: Gradient(colors: [.green, .yellow, .orange, .red, .pink, .purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                            .clipShape(Circle())
                                            .padding(2)
                                    })
                        .frame(width: 60, height: 60)
                    //MARK: - Camera
                    ZStack {
                        Circle()
                            .fill()
                            .foregroundColor(colorScheme == .light ? Color(#colorLiteral(red: 0.9344686643, green: 0.9344686643, blue: 0.9344686643, alpha: 1)) : Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .foregroundColor(.blue)
                    }
                    .padding(2)
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        self.isShowingImageAlertSheet = true
                    }
                    
                    IconCircle(imageName: "all-icon", pickedImage: $pickedImage)
                    IconCircle(imageName: "calendar-icon", pickedImage: $pickedImage)
                }
                .padding()
                    
                Spacer()
                
                //MARK: - Ready Button
                Button(action: {
                    viewModel.checklists.append(CheckList(name: title, imageName: pickedImage))
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Готово")
                        .font(.system(size: 20, weight: .regular, design: .default))
                        .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(25)
                })
                .padding()
            }
            .navigationBarTitle("Новый список")
            .navigationBarTitleDisplayMode(.inline)
            .actionSheet(isPresented: $isShowingImageAlertSheet) {
                ActionSheet(title: Text("Выберите опцию"), message: nil, buttons: [
                    .default(Text("Снять фото")) {
                        self.isShowingImagePicker = true
                        self.sourceType = .camera
                    },
                    .default(Text("Выбрать из библиотеки")) {
                        self.isShowingImagePicker = true
                        self.sourceType = .photoLibrary
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: self.$isShowingImagePicker, content: {
                ImagePicker(image: $image, sourceType: sourceType)
                    .edgesIgnoringSafeArea(.bottom)
            })
            .onAppear {
                print(pickedColor.description)
            }
        }
    }
}

struct ColorCircle: View {
    @Environment(\.colorScheme) var colorScheme
    var color: Color
    @Binding var pickedColor: Color
    var body: some View {
        ZStack {
            if pickedColor == color {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
            Circle()
                .fill()
                .foregroundColor(color)
                .padding(2)
        }
        .frame(width: 60, height: 60)
        .onTapGesture {
            self.pickedColor = color
        }
    }
}

struct IconCircle: View {
    @Environment(\.colorScheme) var colorScheme
    var imageName: String
    @Binding var pickedImage: String
    var body: some View {
        ZStack {
            if pickedImage == imageName {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
            Circle()
                .fill()
                .foregroundColor(colorScheme == .light ? Color(#colorLiteral(red: 0.9344686643, green: 0.9344686643, blue: 0.9344686643, alpha: 1)) : Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                .padding(2)
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding()
        }
        .frame(width: 60, height: 60)
        .onTapGesture {
            self.pickedImage = imageName
        }
    }
}

struct ColorPickerForListView: View {
    @State var title: String
    @State var pickedImage: String
    @Binding var pickedColor: Color
    @Binding var textForegroundColor: Color
    var body: some View {
        VStack {
            TestListCardView(title: $title, imageTitle: $pickedImage, backgroundColor: $pickedColor, textForegroundColor: $textForegroundColor, image: .constant(nil))
                .frame(width: 200, height: 150)
                .padding()
            ColorPicker("Фоновый цвет", selection: $pickedColor)
                .frame(width: 200, height: 200)
            ColorPicker("Цвет шрифта", selection: $textForegroundColor)
                .frame(width: 200, height: 200)
            Spacer()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
