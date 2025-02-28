//
//  Snack.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

public struct Snack<Image: View, Content: View>: Toast {
    @ViewBuilder var image: Image
    @ViewBuilder var content: Content
    
    public var id = UUID()
    
    public init(
        @ViewBuilder image: () -> Image,
        @ViewBuilder content: () -> Content
    ) {
        self.image = image()
        self.content = content()
    }
    
    public var body: some View {
        HStack(spacing: 15) {
            image
            
            content
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
    }
}

@available(iOS 17.0, *)
#Preview("Snack", traits: .sizeThatFitsLayout) {
    Snack {
        Image(systemName: "flame")
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
    } content: {
        Text("Извините. Что-то пошло не так...")
            .font(.subheadline)
    }
    .padding()
}
