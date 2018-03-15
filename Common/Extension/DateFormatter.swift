//
//  DateFormatter.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

extension DateFormatter {
    /**
     標準DateFormatter
     - returns: DateFormatter
     */
    class func defaultDateFormatter() -> DateFormatter {
        let calendar = Calendar(identifier: .gregorian)
        let formatter =  DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
}

