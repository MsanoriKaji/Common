//
//  UIView.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIView {

    var x: CGFloat {
        get {
            return self.frame.minX
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    var y: CGFloat {
        get {
            return self.frame.minY
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }

    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }

    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }

    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }

    var left: CGFloat {
        get {
            return self.frame.minX
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    var right: CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            self.frame.origin.x = newValue - self.frame.size.width
        }
    }

    var top: CGFloat {
        get {
            return self.frame.minY
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    var bottom: CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            self.frame.origin.y = newValue - self.frame.size.height
        }
    }

    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 0.0, y: 0.0)
        self.layer.render(in: context!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return image
    }
}

// MARK: - SnapKit
extension UIView {
    public func addFixSubView(_ view: UIView) {
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
}
