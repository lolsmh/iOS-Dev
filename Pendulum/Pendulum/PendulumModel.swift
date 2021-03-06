//
//  PendulumModel.swift
//  Pendulum
//
//  Created by Даниил Апальков on 09.12.2020.
//

import Foundation

struct PendulumModel {
    var isFirst: Bool
    var g: Double = 9.8
    var distantion: Double
    var deflectionAngle: Double = 10
    var T: Double
    var time: Double
    
    init(isFirst: Bool, distantion: Double) {
        self.distantion = distantion/300
        self.isFirst = isFirst
        self.T = 2 * Double.pi * (self.distantion / g).squareRoot()
        self.time = T/2
    }
}
