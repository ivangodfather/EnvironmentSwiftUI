//
//  ContentView.swift
//  EnvironmentSwiftUI
//
//  Created by Ivan Ruiz Monjo on 18/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct KnobShape: Shape {
    var size = CGFloat(50)
    func path(in rect: CGRect) -> Path {
        let circleRect = rect.insetBy(dx: size, dy: size)
        return Path { path in
            path.addEllipse(in: circleRect)
            path.addRect(CGRect(x: rect.midX - size / 2,
                                y: 0,
                                width: size,
                                height: size))
        }
    }
}

struct Knob: View {
    
    var size: CGFloat? = nil
    var color: Color? = nil
    @Environment(\.knobSize) var envKnobSize
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.knobColor) var envKnobColor
    
    var angle: Double
    
    var body: some View {
        KnobShape(size: size ?? envKnobSize)
            //.fill(colorScheme == .dark ? Color.white : Color.black)
            .fill(color ?? envKnobColor)
            .rotationEffect(.degrees(angle))
    }
}

struct ContentView: View {
    
    @State var angle = Double(0)
    @State var knobSize = CGFloat(50)
    @State var colorHue = Double(0)
    
    var body: some View {
        VStack {
            Spacer()
            Knob(angle: angle)
                .frame(width: 200, height: 200)
                .knobColor(color: Color(hue: colorHue, saturation: 0.5, brightness: 0.5))
            Knob(size: knobSize, color: .red, angle: angle)
                .frame(width: 200, height: 200)
            HStack {
                Text("Angle")
                Slider(value: $angle, in: 0...360)
            }
            HStack {
                Text("Knob size")
                Slider(value: $knobSize, in: 0...100)
            }
            HStack {
                Text("Color hue")
                Slider(value: $colorHue, in: 0...1)
            }
            Button(action: {
                withAnimation {
                    self.angle =  0
                    self.knobSize = 0
                    self.colorHue = 0
                }
            }) {
                Text("Reset")
            }
            Spacer()
        }
        .knobSize(size: 80)
        
    }
}

extension View {
    func knobSize(size: CGFloat) -> some View {
        return environment(\.knobSize, size)
    }
    
    func knobColor(color: Color) -> some View {
        return environment(\.knobColor, color)
    }
}

extension EnvironmentValues {
    var knobSize: CGFloat {
        get { self[KnobSizeKey] }
        set { self[KnobSizeKey] = newValue }
    }
    
    var knobColor: Color {
        get { self[KnobColorKey] }
        set { self[KnobColorKey] = newValue }
    }
}

struct KnobSizeKey: EnvironmentKey {
    static var defaultValue: CGFloat = 50
}

struct KnobColorKey: EnvironmentKey {
    static var defaultValue: Color = .red
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
