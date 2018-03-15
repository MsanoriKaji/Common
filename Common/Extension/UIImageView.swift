//
//  UIImageView.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/14.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    private static let defultIndicatorSize = CGSize(width: 40.0, height: 40.0)

    private struct AssociatedKey {
        static var indicatorKey = UInt()
        static var styleKey = UInt()
        static var wideKey = UInt()
        static var heightKey = UInt()
    }

    var activityIndicator: UIActivityIndicatorView? {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKey.indicatorKey) as? UIActivityIndicatorView else {
                return nil
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.indicatorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    var indicatorStyle: UIActivityIndicatorViewStyle {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKey.styleKey) as? UIActivityIndicatorViewStyle else {
                return .whiteLarge
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.styleKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// IndicatorWidth
    @IBInspectable internal var indicatorWidth: CGFloat {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKey.wideKey) as? CGFloat else {
                return UIImageView.defultIndicatorSize.width
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.wideKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// IndicatorHeight
    @IBInspectable internal var indicatorHeight: CGFloat {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKey.heightKey) as? CGFloat else {
                return UIImageView.defultIndicatorSize.height
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.heightKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }


    func showIndicator() {
        guard self.activityIndicator == nil else { // 表示中の場合処理なし
            return
        }

        let indicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicator.hidesWhenStopped = true
        indicator.frame = CGRect(x: 0.0,
                                 y: 0.0,
                                 width: UIImageView.defultIndicatorSize.width,
                                 height: UIImageView.defultIndicatorSize.height)
        indicator.activityIndicatorViewStyle = self.indicatorStyle
        indicator.center = self.center
        indicator.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin]
        indicator.isUserInteractionEnabled = false
        self.activityIndicator = indicator

        OperationQueue.main.addOperation { [weak self] in
            guard let indicator = self?.activityIndicator else {
                return
            }
            indicator.stopAnimating()

        }
    }

    func hideIndicator() {
        OperationQueue.main.addOperation { [weak self] in
            guard let indicator = self?.activityIndicator else {
                return
            }
            indicator.stopAnimating()
        }
    }
}
