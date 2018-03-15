//
//  Int.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

extension Int {
    var float: Float {
        return Float(self)
    }

    var double: Double {
        return  Double(self)
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
