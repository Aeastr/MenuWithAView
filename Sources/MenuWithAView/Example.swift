//
//  Example.swift
//  MenuWithAView
//
//  Created by Aether on 11/05/2025.
//

import SwiftUI

public struct MenuWithAView_Example: View {
    
    @State var placement: ContextMenuAccessoryPlacement = .top
    @State var alignment: ContextMenuAccessoryAlignment = .center
    @State var location: ContextMenuAccessoryLocation = .preview
    
    private let blueGradient = [
        Color(red: 0.2, green: 0.36, blue: 0.90),
        Color(red: 0.15, green: 0.45, blue: 0.85)
    ]
    
    // Human-readable names
    
    private var placementName: String {
        switch placement {
        case .top: return "top"
        case .bottom: return "bottom"
        case .center: return "center"
        case .leading: return "leading"
        case .trailing: return "trailing"
        }
    }
    
    private var alignmentName: String {
        switch alignment {
        case .top: return "top"
        case .bottom: return "bottom"
        case .center: return "center"
        case .leading: return "leading"
        case .trailing: return "trailing"
        }
    }
    
    private var locationName: String {
        switch location {
        case .background: return "background"
        case .menu: return "menu"
        case .preview: return "preview"
        }
    }
    
    public init(){}
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 34) {
                    // Description
                    Text("Attach a view to your context menu with flexible placement, location, alignment, and tracking. Use the controls below and long-press the demo box to see it in action.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    // Demo Box
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: blueGradient),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 200, height: 120)
//                        .shadow(color: Color(red: 0.15, green: 0.45, blue: 0.85).opacity(0.25), radius: 10, y: 1)
//                        .contentShape([.contextMenuPreview, .interaction], RoundedRectangle(cornerRadius: 16))
                        .contextMenu {
                            Button { } label: { Label("Button", systemImage: "circle") }
                        }
                        .contextMenuAccessory(
                            placement: placement,
                            location: location,
                            alignment: alignment,
                            trackingAxis: .yAxis
                        ) {
                            Text("Accessory View")
                                .font(.title2)
                                .padding(8)
                                .background(Color.blue.opacity(1.0))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(16)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 10)
                    
                    HStack{
                        VStack(alignment: .center, spacing: 8) {
                            Text("Placement")
                                .font(.headline)
                            Picker("Placement", selection: $placement) {
                                Text("Top").tag(ContextMenuAccessoryPlacement.top)
                                Text("Bottom").tag(ContextMenuAccessoryPlacement.bottom)
                                Text("Center").tag(ContextMenuAccessoryPlacement.center)
                                Text("Leading").tag(ContextMenuAccessoryPlacement.leading)
                                Text("Trailing").tag(ContextMenuAccessoryPlacement.trailing)
                            }
                            .pickerStyle(.menu)
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(alignment: .center, spacing: 8) {
                            Text("Alignment")
                                .font(.headline)
                            Picker("Alignment", selection: $alignment) {
                                Text("Top").tag(ContextMenuAccessoryAlignment.top)
                                Text("Bottom").tag(ContextMenuAccessoryAlignment.bottom)
                                Text("Center").tag(ContextMenuAccessoryAlignment.center)
                                Text("Leading").tag(ContextMenuAccessoryAlignment.leading)
                                Text("Trailing").tag(ContextMenuAccessoryAlignment.trailing)
                            }
                            .pickerStyle(.menu)
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(alignment: .center, spacing: 8) {
                            Text("Location")
                                .font(.headline)
                            Picker("Location", selection: $location) {
                                Text("Background").tag(ContextMenuAccessoryLocation.background)
                                Text("Menu").tag(ContextMenuAccessoryLocation.menu)
                                Text("Preview").tag(ContextMenuAccessoryLocation.preview)
                            }
                            .pickerStyle(.menu)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    // Code Example
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Example Usage")
                            .font(.headline)
                        Text(
                            """
                            .contextMenu {
                               ...
                            }
                            .contextMenuAccessory(
                               placement: .\(placementName),
                               location: .\(locationName),
                               alignment: .\(alignmentName),
                               trackingAxis: .yAxis
                            ) {
                               Text("Accessory View")
                            }
                            """
                        )
                        .font(.system(.body, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("MenuWithAView")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MenuWithAView_Example()
}
