//
//  ContentView.swift
//  Pendulum
//
//  Created by Даниил Апальков on 09.12.2020.
//

import SwiftUI

struct ContentView: View {
        @State var str = ""
        @State var isFirst: Bool = true
        @State var distance: Int = 100
        @ObservedObject var viewModel = ViewModel(isFirst: true, distantion: 100)
        var dist: Double = 75
        
        var body: some View {
            NavigationView {
                Form {
                    Section {
                        Picker("Расстояние до точки подвеса (мм)", selection: $distance) {
                            Group {
                                Text("100 мм").tag(100)
                                Text("125 мм").tag(125)
                                Text("150 мм").tag(150)
                                Text("175 мм").tag(175)
                                Text("200 мм").tag(200)
                                Text("225 мм").tag(225)
                                Text("250 мм").tag(250)
                                Text("275 мм").tag(275)
                                Text("300 мм").tag(300)
                                Text("325 мм").tag(325)
                            }
                            Group {
                                Text("350 мм").tag(350)
                                Text("375 мм").tag(375)
                                Text("400 мм").tag(400)
                                Text("425 мм").tag(425)
                                Text("450 мм").tag(450)
                                Text("475 мм").tag(475)
                                Text("500 мм").tag(500)
                                Text("525 мм").tag(525)
                                Text("550 мм").tag(550)
                                Text("575 мм").tag(575)
                            }
                            Group {
                                Text("600 мм").tag(600)
                                Text("625 мм").tag(625)
                                Text("650 мм").tag(650)
                                Text("675 мм").tag(675)
                                Text("700 мм").tag(700)
                            }
                        }
                        Picker("Номер опыта", selection: $isFirst) {
                            Text("№1").tag(true)
                            Text("№2").tag(false)
                        }
                        
                    }
                    NavigationLink(destination: PendulumWithLoads(viewModel: viewModel.changeModel(distantion: distance, isFirst: isFirst))) {
                        Text("Моделировать маятник")
                    }
                }
                    .navigationBarTitle("Маятник Катера")
            }
        }
    }

    //
    //struct ContentView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        ContentView()
    //    }
    //}
        
struct PendulumWithLoads: View {
    var viewModel: ViewModel
    @State var angle: Angle = Angle()
    @State var tap: Bool = false
    
    func startPendulum() {
        if angle == viewModel.angle {
            angle = -viewModel.angle
        } else {
            angle = viewModel.angle
        }
    }
    
    
    func start() {
        self.angle = viewModel.angle
    }
    
    var body: some View {
        VStack {
            Pendulum(angle: angle, isFirst: viewModel.isFirst, distanceBetweenLoads: viewModel.distantion)
                .stroke(Color.black, lineWidth: 4)
            CoolButton(tap: tap)
                .onTapGesture {
                    withAnimation(Animation.easeInOut(duration: viewModel.time).repeatForever()) {
                        if !tap {
                            self.startPendulum()
                        }
                    }
                    withAnimation(.easeInOut) {
                        self.tap = true
                    }
                }
        }
        .onAppear{
            self.start()
        }
    }
}

struct CoolButton: View {
    var tap: Bool
    var body: some View {
        Text("Запустить")
        .font(.system(size: 20, weight: .semibold, design: .rounded))
        .frame(width: 200, height: 50)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: tap ? 30 : 20, x: -20, y: -20)
        .shadow(color: Color(#colorLiteral(red: 0.6798058018, green: 0.7235490354, blue: 0.7400283897, alpha: 1)), radius: tap ? 30 : 20, x: 20, y: 20)
        .scaleEffect(tap ? 0.94 : 1)
    }
}
