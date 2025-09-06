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
    let accessoryView: AccessoryItem<Content>
    
    func makeUIView(context: Context) -> ContextMenuIdentifierUIView<Content> {
        let uiView = ContextMenuIdentifierUIView(
            accessoryView: accessoryView
        )
        return uiView
    }
    
    func updateUIView(_ uiView: ContextMenuIdentifierUIView<Content>, context: Context) {
        uiView.hostingView.rootView = accessoryView.content
    }
}

class AnyContextMenuIdentifierUIView: UIView {
    var accessoryView: UIView?
    var configuration: ContextMenuAccessoryConfiguration

    init(accessoryView: UIView? = nil, configuration: ContextMenuAccessoryConfiguration) {
        self.accessoryView = accessoryView
        self.configuration = configuration
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContextMenuIdentifierUIView<Content: View>: AnyContextMenuIdentifierUIView {
    let hostingView: _UIHostingView<Content>

    init(accessoryView: AccessoryItem<Content>) {
        self.hostingView = _UIHostingView(rootView: accessoryView.content)
        super.init(accessoryView: hostingView, configuration: accessoryView.configuration)

        UIContextMenuInteraction.swizzle_delegate_getAccessoryViewsForConfigurationIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    MenuWithAView_Example()
}
