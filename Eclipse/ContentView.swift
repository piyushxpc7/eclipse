//
//  ContentView.swift
//  Eclipse
//
//  Created by user@87 on 21/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.title)
                .padding()
        }
        .padding() // Add padding to the entire VStack
    }
}

#Preview {
    ContentView()
}

extension Color {
    init(hex: String) {
        let r, g, b: Double
        
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        
        var rgb: UInt64 = 0
        Scanner(string: hexColor).scanHexInt64(&rgb)
        
        r = Double((rgb >> 16) & 0xFF) / 255
        g = Double((rgb >> 8) & 0xFF) / 255
        b = Double(rgb & 0xFF) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}
