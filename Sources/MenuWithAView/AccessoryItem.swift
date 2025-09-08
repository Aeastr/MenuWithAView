//
//  ContextMenuAccessory.swift
//  MenuWithAView
//
//  Created by Aether Aurelia Seb Vidal on 11/05/2025.
//

import SwiftUI
import ContextMenuAccessoryStructs

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

public struct ContextMenuProxy: @unchecked Sendable {

    var dismissBlock: (() -> Void)?

    @MainActor
    public func dismiss() {
        dismissBlock?()
    }
}

/// Configuration for context menu accessories, including placement, location, alignment, and tracking axis.
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
