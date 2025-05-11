//
//  View+ContextMenuAccessories.swift
//  MenuWithAView
//
//  Created by Aether Aurelia and Seb Vidal on 11/05/2025.
//

import SwiftUI
import UIKit

public extension View {
    func contextMenu<MenuItems, Content>(@ViewBuilder menuItems: () -> MenuItems, @ViewBuilder accessoryContent: @escaping () -> AccessoryItem<Content>) -> some View where MenuItems : View, Content : View {
        background {
            ContextMenuIdentifierView(accessoryView: accessoryContent)
                .accessibilityHidden(true)
        }
        .contextMenu(menuItems: menuItems)
    }
}
