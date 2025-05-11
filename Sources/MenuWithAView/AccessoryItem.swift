//
//  ContextMenuAccessory.swift
//  MenuWithAView
//
//  Created by Aether Aurelia Seb Vidal on 11/05/2025.
//

import SwiftUI
import ContextMenuAccessoryStructs

public struct AccessoryItem<Content: View>: View {
    let configuration: Configuration
    let content: () -> Content

    public init(placement: Placement, content: @escaping () -> Content) {
        self.configuration = Configuration(placement: placement)
        self.content = content
    }
    
    public var body: some View {
        content()
    }
}

extension AccessoryItem {
    public typealias Location = ContextMenuAccessoryLocation
    
    public typealias Placement = ContextMenuAccessoryPlacement
    
    public typealias Alignment = ContextMenuAccessoryAlignment
    
    public typealias TrackingAxis = ContextMenuAccessoryTrackingAxis
    
    typealias Configuration = ContextMenuAccessoryConfiguration
}

/// Builder that aggregates AccessoryItem and raw Views into accessory items
@resultBuilder
public struct AccessoryContentBuilder {
    public static func buildBlock(_ items: [AccessoryItem<AnyView>]...) -> [AccessoryItem<AnyView>] {
        items.flatMap { $0 }
    }

    @MainActor public static func buildExpression<Content: View>(_ item: AccessoryItem<Content>) -> [AccessoryItem<AnyView>] {
        // Preserve placement by wrapping in AnyView
        [AccessoryItem<AnyView>(placement: item.configuration.placement) {
            AnyView(item)
        }]
    }

    @MainActor public static func buildExpression<Content: View>(_ view: Content) -> [AccessoryItem<AnyView>] {
        // Default placement .center for raw views
        [AccessoryItem<AnyView>(placement: .center) {
            AnyView(view)
        }]
    }
}

public enum ContextMenuAccessoryLocation: Int {
    case background = 0
    case preview = 1
    case menu = 2
}

public enum ContextMenuAccessoryPlacement: UInt64 {
    case top = 1
    case leading = 2
    case center = 3
    case bottom = 4
    case trailing = 8
}

public enum ContextMenuAccessoryAlignment: UInt64 {
    case top = 1
    case leading = 2
    case center = 3
    case bottom = 4
    case trailing = 8
}

public struct ContextMenuAccessoryTrackingAxis: OptionSet, Sendable {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static var xAxis: ContextMenuAccessoryTrackingAxis {
        return ContextMenuAccessoryTrackingAxis(rawValue: 1 << 0)
    }
    
    public static var yAxis: ContextMenuAccessoryTrackingAxis {
        return ContextMenuAccessoryTrackingAxis(rawValue: 1 << 1)
    }
}

struct ContextMenuAccessoryConfiguration {
    var location: ContextMenuAccessoryLocation = .preview
    
    // controls the attachment point
    var placement: ContextMenuAccessoryPlacement = .center
    
    // controls alignment to attachment
    var alignment: ContextMenuAccessoryAlignment = .leading
    
    var trackingAxis: ContextMenuAccessoryTrackingAxis = [.xAxis, .yAxis]
    
    var anchor: ContextMenuAccessoryAnchor {
        return ContextMenuAccessoryAnchor(attachment: placement.rawValue, alignment: alignment.rawValue)
    }
}

#Preview {
    MenuWithAView_Example()
}
