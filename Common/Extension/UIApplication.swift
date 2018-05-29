//
//  UIApplication.swift
//  Common
//
//  Created by ma_kaji on 2018/05/29.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

extension UIApplication {

    public final class func topViewController(controller: UIViewController?
        = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
