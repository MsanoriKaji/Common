//
//  UIButton.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    private struct AssociatedKey {
        static var topExtensionInsetKey = UInt()
        static var leftExtensionInsetKey = UInt()
        static var bottomExtensionInsetKey = UInt()
        static var rightExtensionInsetKey = UInt()
    }

    /// Topタップ領域拡張
    @IBInspectable internal var topExtensionInset: CGFloat {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKey.topExtensionInsetKey) as? CGFloat else {
                return 0.0
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.topExtensionInsetKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// leftタップ領域拡張
    @IBInspectable internal var leftExtensionInset: CGFloat {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKey.leftExtensionInsetKey) as? CGFloat else {
                return 0.0
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.leftExtensionInsetKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// bottomタップ領域拡張
    @IBInspectable internal var bottomExtensionInset: CGFloat {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKey.bottomExtensionInsetKey) as? CGFloat else {
                return 0.0
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.bottomExtensionInsetKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// rightタップ領域拡張
    @IBInspectable internal var rightExtensionInset: CGFloat {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKey.rightExtensionInsetKey) as? CGFloat else {
                return 0.0
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.rightExtensionInsetKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let extensionInset = UIEdgeInsets(top: -topExtensionInset,
                                          left: -leftExtensionInset,
                                          bottom: -bottomExtensionInset,
                                          right: -rightExtensionInset)
        // hit領域を拡張
        let hitFrame = UIEdgeInsetsInsetRect(bounds, extensionInset)
        // 拡大した領域にポイントが入っているかどうか
        return hitFrame.contains(point)
    }

}
