//
//  UIContextMenuInteraction+Swizzle.swift
//  MenuWithAView
//
//  Created by Aether Aurelia and Seb Vidal on 11/05/2025.
//

import UIKit
import SwiftUI

extension UIContextMenuInteraction {
    private static var needsSwizzle_delegate_getAccessoryViewsForConfiguration: Bool = true
    
    static func swizzle_delegate_getAccessoryViewsForConfigurationIfNeeded() {
        guard needsSwizzle_delegate_getAccessoryViewsForConfiguration else { return }
        
        let originalString = [":", "Configuration", "For", "Views", "Accessory", "get", "_", "delegate", "_"].reversed().joined()
        let swizzledString = [":", "Configuration", "For", "Views", "Accessory", "get", "_", "delegate", "_", "swizzled"].reversed().joined()
        
        let originalSelector = NSSelectorFromString(originalString)
        let swizzledSelector = NSSelectorFromString(swizzledString)
        
        guard instancesRespond(to: originalSelector), instancesRespond(to: swizzledSelector) else { return }
        
        let originalMethod = class_getInstanceMethod(UIContextMenuInteraction.self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(UIContextMenuInteraction.self, swizzledSelector)
        
        guard let originalMethod, let swizzledMethod else { return }
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
        
        needsSwizzle_delegate_getAccessoryViewsForConfiguration = false
    }
    
    @objc dynamic func swizzled_delegate_getAccessoryViewsForConfiguration(_ configuration: UIContextMenuConfiguration) -> [UIView] {
        // Collect all ContextMenuIdentifierUIView instances in the hierarchy
        guard let idViews = view?.allSubviews(ofType: ContextMenuIdentifierUIView.self), !idViews.isEmpty else {
            // No custom accessories, fallback to original implementation
            return swizzled_delegate_getAccessoryViewsForConfiguration(configuration)
        }
        // Sort by placement to ensure correct position ordering
        let allIDs = idViews.sorted { lhs, rhs in
            lhs.configuration.placement.rawValue < rhs.configuration.placement.rawValue
        }

        // Create an accessory UIView for each identifier view based on its configuration
        let accessoryViews = allIDs.compactMap { identifierView -> UIView? in
            let contentView = identifierView.accessoryView
            contentView.frame.size = contentView.intrinsicContentSize

            guard let accessoryWrapper = UIContextMenuInteraction.accessoryView(configuration: identifierView.configuration) else {
                return nil
            }
            accessoryWrapper.frame.size = contentView.intrinsicContentSize
            accessoryWrapper.addSubview(contentView)
            return accessoryWrapper
        }
        return accessoryViews
    }
}
