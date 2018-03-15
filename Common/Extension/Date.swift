//
//  Date.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation


/**
 表示種別

 - DateString:            yyyy/MM/dd
 - DateStringNoSlash:     yyyyMMdd
 - DateTimeString:        yyyy/MM/dd HH:mm
 - DateTimeStringNoSlash: yyyyMMddHHmm
 - DateTimeSecondString:  yyyy/MM/dd HH:mm:ss
 - ShortDateString:       MM/dd
 - ShortDateTimeString:   MM/dd HH:mmm
 - DateTimeStringJp:      M月d日H時
 */
public enum DateDisplayType {
    case DateString, DateStringNoSlash, DateTimeString, DateTimeStringNoSlash, DateTimeSecondString, ShortDateString, ShortDateTimeString, DateTimeStringJp

    func toFormat() -> DateFormatter{

        let formatter: DateFormatter = DateFormatter.defaultDateFormatter()

        switch self {
        case .DateString:
            formatter.dateFormat = "yyyy/MM/dd"
        case .DateStringNoSlash:
            formatter.dateFormat = "yyyyMMdd"
        case .DateTimeString:
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
        case .DateTimeStringNoSlash:
            formatter.dateFormat = "yyyyMMddHHmm"
        case .DateTimeSecondString:
            formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        case .ShortDateString:
            formatter.dateFormat = "MM/dd"
        case .ShortDateTimeString:
            formatter.dateFormat = "MM/dd HH:mm"
        case .DateTimeStringJp:
            formatter.dateFormat = "M月d日H時"        }
        return formatter
    }
}


extension Date {

    var components: DateComponents {
        let componentSet: Set<Calendar.Component> = [.year, .month, .day,
                                                     .weekday, .hour, .minute, .second]
        let calendar = Calendar(identifier: .gregorian)
        return calendar.dateComponents(componentSet, from: self)
    }

    var year: Int {
        return components.year!
    }

    var month: Int {
        return components.month!
    }

    var day: Int {
        return components.day!
    }

    var weekday: Int {
        return components.weekday!
    }

    var hour: Int {
        return components.hour!
    }

    var minute: Int {
        return components.minute!
    }

    var second: Int {
        return components.second!
    }

    static func create(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second

        return Calendar.current.date(from: components)
    }

    /*!
     現在日かどうかを判定する

     - returns: true:当日 flase:
     */
    func sameToDay() -> Bool {
        let today = Date()

        return self.year == today.year
            && self.month == today.month
            && self.day == today.day
    }

    /*!
     Formatに対応する文字列を返却する

     - parameter format: フォーマット

     - returns: 対応文字列
     */
    func dispString(format: DateFormatter) -> String {
        return format.string(from: self)
    }

    /*!
     Formatに対応する文字列を返却する

     - parameter type: フォーマット種別

     - returns: 対応文字列
     */
    func dispString(type: DateDisplayType) -> String {
        return type.toFormat().string(from: self)
    }

}

extension Date : Strideable {

    public typealias stride = TimeInterval
    public func advanced(by n: TimeInterval) -> Date {
        return type(of: self).init(timeInterval: n, since: self)
    }

    /**
     指定の NSTimeInterval 秒進んだ Date を返します。

     :param: n 何秒進むか

     :returns: 指定秒進んだ Date
     */
    public func advanced(by sec: Int) -> Date {
        return self.advanced(by: Double(sec))
    }

    /**
     指定の Date がどのくらいの秒数離れているかを NSTimeInterval で返します。

     :param: other 指定の Date

     :returns: 何秒離れているかを示す NSTimeInterval
     */
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSince(self)
    }
}

