//
//  ViewModel.swift
//  Pendulum
//
//  Created by Даниил Апальков on 09.12.2020.
//

import SwiftUI

class ViewModel: ObservableObject {
    var isFirst: Bool
    var distantion: Int
    var angle: Angle { Angle(degrees: model.deflectionAngle) }
    var time: Double { model.time }
    private var number: Int = 75
    
    @Published var model: PendulumModel
    
    init(isFirst: Bool, distantion: Int) {
        self.isFirst = isFirst
        self.distantion = distantion
        self.model = PendulumModel(isFirst: isFirst, distantion: Double(distantion))
    }
    
    func changeModel(distantion: Int, isFirst: Bool) -> ViewModel {
        ViewModel(isFirst: isFirst, distantion: distantion)
    }
}
