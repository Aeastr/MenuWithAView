//
//  View+ContextMenuAccessories.swift
//  MenuWithAView
//
//  Created by Aether Aurelia and Seb Vidal on 11/05/2025.
//

import SwiftUI
import UIKit
import ContextMenuAccessoryStructs

private struct AccessoryWrapper<AccessoryView: View>: View {
    let configuration: ContextMenuAccessoryConfiguration
    let accessory: (ContextMenuProxy) -> AccessoryView

    var body: some View {
        ContextMenuIdentifierView(
            configuration: configuration,
            accessory: accessory
        )
        .accessibilityHidden(true)
    }
}

public extension View {
    /// Adds an accessory view to instances of `.contextMenu`.
    ///
    /// > Note: This modifier should be used in combination with `.contextMenu`.
    ///
    /// - Parameters:
    ///   - placement: The placement of the accessory relative to the context menu. *(Optional, default: `.center`)*
    ///   - location: The location where the accessory should appear. *(Optional, default: `.preview`)*
    ///   - alignment: The alignment of the accessory within its container. *(Optional, default: `.leading`)*
    ///   - trackingAxis: The axis along which the accessory tracks user interaction. *(Optional, default: `[.xAxis, .yAxis]`)*
    ///   - accessory: A view builder that creates the accessory view.
    ///
    /// For more details on default values, see ``ContextMenuAccessoryConfiguration``.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// Text("Turtle Rock")
    ///     .padding()
    ///     .contextMenu {
    ///         Button(action: {}) {
    ///             Label("Button", systemImage: "circle")
    ///         }
    ///     }
    ///     .contextMenuAccessory(
    ///         placement: placement,
    ///         location: location,
    ///         alignment: alignment,
    ///         trackingAxis: .yAxis
    ///     ) {
    ///         Text("Accessory View")
    ///             .font(.title2)
    ///             .padding(8)
    ///             .background(Color.blue.opacity(0.6))
    ///             .clipShape(RoundedRectangle(cornerRadius: 12))
    ///             .padding(16)
    ///     }
    /// ```
    func contextMenuAccessory<AccessoryView: View>(
        placement: ContextMenuAccessoryPlacement? = nil,
        location: ContextMenuAccessoryLocation? = nil,
        alignment: ContextMenuAccessoryAlignment? = nil,
        trackingAxis: ContextMenuAccessoryTrackingAxis? = nil,
        @ViewBuilder accessory: () -> AccessoryView
    ) -> some View {
        var config = ContextMenuAccessoryConfiguration()
        if let placement = placement { config.placement = placement }
        if let location = location { config.location = location }
        if let alignment = alignment { config.alignment = alignment }
        if let trackingAxis = trackingAxis { config.trackingAxis = trackingAxis }

        let accessory = accessory()
        let wrapped = background {
            AccessoryWrapper(configuration: config, accessory: { _ in accessory })
        }
        return wrapped
    }

    /// Adds an accessory view to instances of `.contextMenu`.
    ///
    /// > Note: This modifier should be used in combination with `.contextMenu`.
    ///
    /// - Parameters:
    ///   - placement: The placement of the accessory relative to the context menu. *(Optional, default: `.center`)*
    ///   - location: The location where the accessory should appear. *(Optional, default: `.preview`)*
    ///   - alignment: The alignment of the accessory within its container. *(Optional, default: `.leading`)*
    ///   - trackingAxis: The axis along which the accessory tracks user interaction. *(Optional, default: `[.xAxis, .yAxis]`)*
    ///   - accessory: A view builder that creates the accessory view.
    ///
    /// For more details on default values, see ``ContextMenuAccessoryConfiguration``.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// Text("Turtle Rock")
    ///     .padding()
    ///     .contextMenu {
    ///         Button(action: {}) {
    ///             Label("Button", systemImage: "circle")
    ///         }
    ///     }
    ///     .contextMenuAccessory(
    ///         placement: placement,
    ///         location: location,
    ///         alignment: alignment,
    ///         trackingAxis: .yAxis
    ///     ) {
    ///         Text("Accessory View")
    ///             .font(.title2)
    ///             .padding(8)
    ///             .background(Color.blue.opacity(0.6))
    ///             .clipShape(RoundedRectangle(cornerRadius: 12))
    ///             .padding(16)
    ///     }
    /// ```
    func contextMenuAccessory<AccessoryView: View>(
        placement: ContextMenuAccessoryPlacement? = nil,
        location: ContextMenuAccessoryLocation? = nil,
        alignment: ContextMenuAccessoryAlignment? = nil,
        trackingAxis: ContextMenuAccessoryTrackingAxis? = nil,
        @ViewBuilder accessory: @escaping (ContextMenuProxy) -> AccessoryView
    ) -> some View {
        var config = ContextMenuAccessoryConfiguration()
        if let placement = placement { config.placement = placement }
        if let location = location { config.location = location }
        if let alignment = alignment { config.alignment = alignment }
        if let trackingAxis = trackingAxis { config.trackingAxis = trackingAxis }

        let wrapped = background {
            AccessoryWrapper(configuration: config, accessory: accessory)
        }
        return wrapped
    }
}

#Preview {
    MenuWithAView_Example()
}
