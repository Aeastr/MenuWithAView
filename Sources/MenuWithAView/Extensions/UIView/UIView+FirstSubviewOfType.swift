//
//  UIView+FirstSubviewOfType.swift
//  MenuWithAView
//
//  Created by Ather Aurelia and Seb Vidal on 11/05/2025.
//

import UIKit

extension UIView {
    func firstSubview<T: UIView>(ofType type: T.Type) -> T? {
        for subview in subviews {
            if let candidate = subview as? T {
                return candidate
            } else if let candidate = subview.firstSubview(ofType: type) {
                return candidate
            }
        }
        
        return nil
    }
    
    /// Recursively collect all descendant subviews of a given type
    func allSubviews<T: UIView>(ofType type: T.Type) -> [T] {
        var result: [T] = []
        for sub in subviews {
            if let match = sub as? T {
                result.append(match)
            }
            result.append(contentsOf: sub.allSubviews(ofType: type))
        }
        return result
    }
}
