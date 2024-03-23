//
//  Modifiers.swift
//  Pizza Loyalty
//
//  Created by özgün aksoy on 2024-03-22.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    var color: Color = .green
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background {
                Capsule().fill(color)
            }
            .foregroundStyle(.white)
    }
}

extension View {
    var buttonModifier: some View {
        modifier(ButtonModifier())
    }
    
    func buttonModifier(_ color: Color) -> some View {
        modifier(ButtonModifier(color: color))
    }
}
