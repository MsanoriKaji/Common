//
//  UITableView.swift
//  Common
//
//  Created by ma_kaji on 2018/05/29.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

extension UITableView {

    public func register(className: String) {
        let nib = UINib(nibName: className, bundle: nil)
        self.register(nib, forCellReuseIdentifier: className)
    }

    /// TopCellにスクロール(
    ///
    /// - Parameter animated: アニメーションの有無
    public func scrollToTopCell(animated: Bool) {
        self.scrollToRow(at: IndexPath.firstIndex(), at: .top, animated: animated)
    }

    /// Topにスクロール
    ///
    /// - Parameter animated: アニメーションの有無
    public func scrollToTop(animated: Bool) {
        self.scrollRectToVisible(CGRect.zero, animated: animated)
    }

}
