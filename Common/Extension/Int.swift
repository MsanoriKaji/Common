//
//  Int.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

extension Int {
    public var float: Float {
        return Float(self)
    }

    public var cgFloat: CGFloat {
        return CGFloat(self)
    }

    public var double: Double {
        return  Double(self)
    }

    public var bool: Bool {
        return (self as NSNumber).boolValue
    }

    /**
     * 3桁カンマ区切り
     */
    func toThousandSeparator() -> String? {
        let num = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3

        return formatter.string(from: num)
    }
}
