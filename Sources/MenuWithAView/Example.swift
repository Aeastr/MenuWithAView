//
//  Example.swift
//  MenuWithAView
//
//  Created by Aether on 11/05/2025.
//

import SwiftUI

public struct MenuWithAView_Example: View {
    
    public init(){}
    
    public var body: some View {
        VStack(spacing: 40) {
            // Multiple AccessoryItem example
            Rectangle()
                .frame(width: 100, height: 200)
                .opacity(0.5)
                .contextMenu {
                    Button {
                    } label: {
                        Label("Button", systemImage: "circle")
                    }
                } accessoryContent: {
                    AccessoryItem(placement: .top) {
                        Text("accessory top")
                    }
                    AccessoryItem(placement: .bottom) {
                        Text("accessory bottom")
                    }
                }

            // Generic View accessory example
            Rectangle()
                .frame(width: 100, height: 200)
                .opacity(0.5)
                .contextMenu {
                    Button { } label: { Label("Tap", systemImage: "star") }
                } accessoryContent: {
                    HStack {
                        Image(systemName: "star.fill")
                        Text("Custom view accessory")
                    }
                    .padding(8)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                }
        }
    }
}

#Preview {
    MenuWithAView_Example()
}
