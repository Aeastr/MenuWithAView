//
//  ContextMenuIdentifierView.swift
//  MenuWithAView
//
//  Created by Aether Aurelia and Seb Vidal on 11/05/2025.
//

import UIKit
import SwiftUI
import ContextMenuAccessoryStructs

struct ContextMenuIdentifierView<Content: View>: UIViewRepresentable {
    let accessoryView: () -> AccessoryItem<Content>
    
    func makeUIView(context: Context) -> some UIView {
        let rootView = accessoryView()
        let hostingView = _UIHostingView(rootView: rootView)
        let identifierView = ContextMenuIdentifierUIView(accessoryView: hostingView, configuration: rootView.configuration)
        
        return identifierView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

class ContextMenuIdentifierUIView: UIView {
    let accessoryView: UIView
    let configuration: ContextMenuAccessoryConfiguration
    
    init(accessoryView: UIView, configuration: ContextMenuAccessoryConfiguration) {
        self.accessoryView = accessoryView
        self.configuration = configuration
        
        super.init(frame: .zero)
        
        UIContextMenuInteraction.swizzle_delegate_getAccessoryViewsForConfigurationIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Generic Accessory View
struct ContextMenuGenericIdentifierView<Content: View>: UIViewRepresentable {
    let accessoryView: () -> Content
    
    init(accessoryView: @escaping () -> Content) {
        self.accessoryView = accessoryView
    }
    
    func makeUIView(context: Context) -> UIView {
        let rootView = accessoryView()
        let hostingView = _UIHostingView(rootView: rootView)
        let defaultConfig = ContextMenuAccessoryConfiguration()
        let identifierView = ContextMenuIdentifierUIView(accessoryView: hostingView, configuration: defaultConfig)
        return identifierView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
