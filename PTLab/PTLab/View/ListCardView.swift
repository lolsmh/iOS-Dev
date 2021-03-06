//
//  ListCardView.swift
//  PTLab
//
//  Created by Даниил Апальков on 03.03.2021.
//

import SwiftUI
// 31 28 33

struct ListCardView: View {
    @State var title: String
    @State var imageTitle: String
    @State var checklist: CheckList
    @Environment(\.colorScheme) var colorScheme
    @State var backgroundColor: Color = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    @State var textForegroundColor: Color = .gray
    
    func adaptColors() -> Color {
        if backgroundColor == Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) {
            if colorScheme == .light {
                return Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            } else {
                // 31 28 33
                return Color(#colorLiteral(red: 0.1792426053, green: 0.1821227268, blue: 0.1858107442, alpha: 1))
            }
        } else {
            return backgroundColor
        }
    }
    
    var body: some View {
        NavigationLink(
            destination: CheckListView(checklist: checklist),
            label: {
                GeometryReader { geo in
                    VStack {
                        HStack(alignment: .center) {
                            Image(imageTitle)
                                .resizable()
                                .frame(width: geo.size.width / 4, height: geo.size.width / 4)
                            Spacer()
                            Text(title)
                                .foregroundColor(textForegroundColor)
                        }
                        .padding([.trailing, .leading, .top])
                        Spacer()
                        HStack {
                            Spacer()
                                Text("\(checklist.items.count)")
                                    .foregroundColor(textForegroundColor)
                                    .font(.system(size: 20, weight: .regular, design: .default))
                        }
                        .padding([.trailing, .leading, .bottom])
                    }
                    .background(colorScheme == .light ? adaptColors() : adaptColors())
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(color: colorScheme == .light ? Color(#colorLiteral(red: 0.9688305325, green: 0.9688305325, blue: 0.9688305325, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)), radius: 10, x: -20, y: -20)
                    .shadow(color: colorScheme == .light ? Color(#colorLiteral(red: 0.929283065, green: 0.929283065, blue: 0.929283065, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)), radius: 10, x: 20, y: 20)
                }
            })
    }
}

struct TestListCardView: View {
    @Binding var title: String
    @Binding var imageTitle: String
    @Binding var backgroundColor: Color
    @Binding var textForegroundColor: Color
    @Binding var image: UIImage?
    @Environment(\.colorScheme) var colorScheme
    
    func adaptColors() -> Color {
        if backgroundColor == Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) {
            if colorScheme == .light {
                return Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            } else {
                // 31 28 33
                return Color(#colorLiteral(red: 0.1792426053, green: 0.1821227268, blue: 0.1858107442, alpha: 1))
            }
        } else {
            return backgroundColor
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            if image != nil {
                VStack {
                    HStack(alignment: .center) {
                        Image(imageTitle)
                            .resizable()
                            .frame(width: geo.size.width / 4, height: geo.size.width / 4)
                        Spacer()
                        Text(title)
                            .foregroundColor(textForegroundColor)
                    }
                    .padding([.trailing, .leading, .top])
                    Spacer()
                    HStack {
                        Spacer()
                            Text("0")
                                .foregroundColor(textForegroundColor)
                                .font(.system(size: 20, weight: .regular, design: .default))
                    }
                    .padding([.trailing, .leading, .bottom])
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(Image(uiImage: image!).resizable().scaledToFill())
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .shadow(color: colorScheme == .light ? Color(#colorLiteral(red: 0.9688305325, green: 0.9688305325, blue: 0.9688305325, alpha: 1)) : Color(#colorLiteral(red: 0.0935086337, green: 0.0935086337, blue: 0.0935086337, alpha: 1)), radius: 10, x: -20, y: -20)
                .shadow(color: colorScheme == .light ? Color(#colorLiteral(red: 0.9258197823, green: 0.9258197823, blue: 0.9258197823, alpha: 1)) : Color(#colorLiteral(red: 0.08522496079, green: 0.08522496079, blue: 0.08522496079, alpha: 1)), radius: 10, x: 20, y: 20)
            } else {
                VStack {
                    HStack(alignment: .center) {
                        Image(imageTitle)
                            .resizable()
                            .frame(width: geo.size.width / 4, height: geo.size.width / 4)
                        Spacer()
                        Text(title)
                            .foregroundColor(textForegroundColor)
                    }
                    .padding([.trailing, .leading, .top])
                    Spacer()
                    HStack {
                        Spacer()
                            Text("0")
                                .foregroundColor(textForegroundColor)
                                .font(.system(size: 20, weight: .regular, design: .default))
                    }
                    .padding([.trailing, .leading, .bottom])
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(adaptColors())
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .shadow(color: colorScheme == .light ? Color(#colorLiteral(red: 0.9746028245, green: 0.9746028245, blue: 0.9746028245, alpha: 1)) : Color(#colorLiteral(red: 0.0935086337, green: 0.0935086337, blue: 0.0935086337, alpha: 1)), radius: 10, x: -20, y: -20)
                .shadow(color: colorScheme == .light ? Color(#colorLiteral(red: 0.921202072, green: 0.921202072, blue: 0.921202072, alpha: 1)) : Color(#colorLiteral(red: 0.08522496079, green: 0.08522496079, blue: 0.08522496079, alpha: 1)), radius: 10, x: 20, y: 20)
            }
        }
    }
}

struct ListCardView_Previews: PreviewProvider {
    static var previews: some View {
        ListCardView(title: "Сегодня", imageTitle: "calendar-icon", checklist: CheckList(name: "Все", imageName: "all-icon"), backgroundColor: .white)
    }
}
