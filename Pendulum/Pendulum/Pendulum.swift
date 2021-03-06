import SwiftUI

struct Pendulum: Shape {
    
    var angle: Angle
    var isFirst: Bool
    var distanceBetweenLoads: Int
    var length1: Double = 100
    var length2: Double = 550
    
    var animatableData: Double {
        get {
           return angle.radians
        }
        set {
            angle = Angle(radians: newValue)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        //MARK: - Main Pendulum
        var p = Path()
        let x = rect.midX
        let y = rect.minY + 50
        let x1 = CGFloat(Double(x) - length1 * sin(angle.radians))
        let y1 = CGFloat(Double(y) - length1 * cos(angle.radians))
        let x2 = CGFloat(length2 * sin(angle.radians) + Double(x))
        let y2 = CGFloat(Double(y) + length2 * cos(angle.radians))
        
        let startPoint = CGPoint(x: x1, y: y1)
        let midPoint = CGPoint(x: x, y: y)
        let endPoint = CGPoint(x: x2, y: y2)
        p.move(to: startPoint)
        p.addLine(to: midPoint)
        p.move(to: CGPoint(x: midPoint.x - 20, y: midPoint.y))
        p.addLine(to: CGPoint(x: midPoint.x + 20, y: midPoint.y))
        p.move(to: midPoint)
        p.addLine(to: endPoint)

        
        //MARK: - First Load
        let mainCenterPoint = CGPoint(x: x, y: y)
        var distance = ((x1 - x)*(x1 - x) + (y1 - y)*(y1 - y)).squareRoot()/2

        if !isFirst {
            distance = ((x2 - x)*(x2 - x) + (y2 - y)*(y2 - y)).squareRoot() - 50
        }
        var centerPoint = CGPoint(
            x: mainCenterPoint.x - distance * CGFloat(sin(isFirst ? -angle.radians + Double.pi : -angle.radians)),
            y: mainCenterPoint.y + distance * CGFloat(cos(isFirst ? -angle.radians + Double.pi : -angle.radians))
        )
        var centerPointRadius = CGPoint(
            x: centerPoint.x + 30, y: centerPoint.y
        )
        p.move(to: centerPointRadius)
        p.addArc(center: centerPoint, radius: 30, startAngle: Angle(), endAngle: Angle(radians: Double.pi*2), clockwise: false)
        
        //MARK: - Second Load
        distance = ((x1 - x)*(x1 - x) + (y1 - y)*(y1 - y)).squareRoot()/2 + CGFloat(distanceBetweenLoads) / 2

        centerPoint = CGPoint(
            x: mainCenterPoint.x - distance * CGFloat(sin(-angle.radians)),
            y: mainCenterPoint.y + distance * CGFloat(cos(-angle.radians))
        )
        centerPointRadius = CGPoint(
            x: centerPoint.x + 30, y: centerPoint.y
        )
        p.move(to: centerPointRadius)
        p.addArc(center: centerPoint, radius: 30, startAngle: Angle(), endAngle: Angle(radians: Double.pi*2), clockwise: false)
        return p
    }
    
    
}
