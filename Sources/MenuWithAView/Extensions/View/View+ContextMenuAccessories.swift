//
//  View+ContextMenuAccessories.swift
//  MenuWithAView
//
//  Created by Aether Aurelia and Seb Vidal on 11/05/2025.
//

import SwiftUI
import UIKit

public extension View {
    /// Context menu with one or more AccessoryItem entries or raw Views
    func contextMenu<MenuItems>(
        @ViewBuilder menuItems: () -> MenuItems,
        @AccessoryContentBuilder accessoryContent: @escaping () -> [AccessoryItem<AnyView>]
    ) -> some View where MenuItems: View {
        background {
            ContextMenuIdentifierView<AnyView>(accessoryViews: accessoryContent)
                .accessibilityHidden(true)
        }
        .contextMenu(menuItems: menuItems)
    }
}
