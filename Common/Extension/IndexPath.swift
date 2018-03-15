//
//  IndexPath.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

extension IndexPath {

    ///　最小のIndexPathを返却
    ///
    /// - Returns: 最小のIndexPath
    static func firstIndex() -> IndexPath {
        return IndexPath(row: 0, section: 0)
    }
}
