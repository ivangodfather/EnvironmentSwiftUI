//
//  Shape.swift
//  EnvironmentSwiftUI
//
//  Created by Ivan Ruiz Monjo on 24/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI

struct KnobShape: Shape {
    var size: CGFloat = 100
    
    func path(in rect: CGRect) -> Path {
        let squareRect = CGRect(x: rect.midX - size / 4, y: 0, width: size / 2, height: size / 2)
        let ellipseRect = CGRect(x: rect.midX - size / 4, y: size / 2, width: size / 2, height: size / 2)
        return Path { path in
            path.addEllipse(in: ellipseRect)
            path.addRect(squareRect)
        }
    }
}

struct Knob: View {
    
    var defaultSize: CGFloat = 100
    
    @Binding var degrees: Double
    @Binding var hue: Double
    @Binding var size: CGFloat
    @Environment(\.knobSize) var envKnobSize
    
    var body: some View {
        KnobShape(size: envKnobSize ?? size)
            .fill(Color(hue: Double(hue), saturation: 0.5, brightness: 0.5))
            .frame(width: 100, height: 100)
            .rotationEffect(.degrees(degrees))
    }
}

struct Knob_Previews: PreviewProvider {
    static var previews: some View {
        Knob(degrees: .constant(0), hue: .constant(0.5), size: .constant(100))
    }
}
