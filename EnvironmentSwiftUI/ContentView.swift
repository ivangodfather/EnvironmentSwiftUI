//
//  ContentView.swift
//  EnvironmentSwiftUI
//
//  Created by Ivan Ruiz Monjo on 18/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct KnobSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat? = nil
}

extension EnvironmentValues {
    var knobSize: CGFloat? {
        get { self[KnobSizeKey.self] }
        set { self[KnobSizeKey.self] = newValue }
    }
}

extension View {
    func knobSize(_ size: CGFloat) -> some View {
        environment(\.knobSize, size)
    }
}

struct ContentView: View {
    @State var degrees: Double = 0
    @State var hue: Double = 0
    @State var size: CGFloat = 0
    
    var body: some View {
        VStack {
            Knob(degrees: $degrees, hue: $hue, size: $size)
            Knob(degrees: $degrees, hue: $hue, size: $size)
            Knob(degrees: $degrees, hue: $hue, size: $size)
            HStack {
                Slider(value: $degrees, in: 0...360)
                Text("Degrees")
            }
            HStack {
                
                Slider(value: $size, in: 0...100)
                Text("Size")
            }
            HStack {
                
                Slider(value: $hue, in: 0...1)
                Text("Hue")
            }
            Button(action: {
                withAnimation {
                    self.degrees = 0; self.hue = 0; self.size = 0;
                }
            }) { Text("Reset ")}
        }.knobSize(50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
