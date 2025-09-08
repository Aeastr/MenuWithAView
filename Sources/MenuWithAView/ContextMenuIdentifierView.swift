//
//  ContextMenuIdentifierView.swift
//  MenuWithAView
//
//  Created by Aether Aurelia and Seb Vidal on 11/05/2025.
//

import UIKit
import SwiftUI
import ContextMenuAccessoryStructs

struct ContextMenuIdentifierView<AccessoryView: View>: UIViewRepresentable {
    let configuration: ContextMenuAccessoryConfiguration
    let accessory: (ContextMenuProxy) -> AccessoryView

    func makeUIView(
        context: Context
    ) -> ContextMenuIdentifierUIView<AccessoryView> {
        let uiView = ContextMenuIdentifierUIView(
            configuration: configuration,
            accessory: accessory
        )
        return uiView
    }
    
    func updateUIView(
        _ uiView: ContextMenuIdentifierUIView<AccessoryView>,
        context: Context
    ) {
        uiView.update(accessory)
    }
}

class AnyContextMenuIdentifierUIView: UIView {
    var accessoryView: UIView?
    var configuration: ContextMenuAccessoryConfiguration
    weak var interaction: UIContextMenuInteraction?

    init(configuration: ContextMenuAccessoryConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContextMenuIdentifierUIView<AccessoryView: View>: AnyContextMenuIdentifierUIView {
    private var hostingView: _UIHostingView<AccessoryView>!

    init(
        configuration: ContextMenuAccessoryConfiguration,
        accessory: (ContextMenuProxy) -> AccessoryView
    ) {
        super.init(configuration: configuration)
        self.hostingView = _UIHostingView(rootView: accessory(makeProxy()))
        accessoryView = hostingView

        UIContextMenuInteraction.swizzle_delegate_getAccessoryViewsForConfigurationIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(_ accessory: (ContextMenuProxy) -> AccessoryView) {
        hostingView.rootView = accessory(makeProxy())
    }

    private func makeProxy() -> ContextMenuProxy {
        ContextMenuProxy { [weak self] in
            self?.dismiss()
        }
    }

    private func dismiss() {
        interaction?.dismissMenu()
    }
}

#Preview {
    MenuWithAView_Example()
}
