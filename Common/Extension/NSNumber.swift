//
//  NSNumber.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

/**
 NSNumberの比較

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺より左辺が大きいかを判定
 */
public func > (left : NSNumber, right : NSNumber) -> Bool {
    return left.compare(right) == ComparisonResult.orderedDescending
}


/**
 NSNumberの比較

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺より左辺が小さいかを判定
 */
public func < (left : NSNumber, right : NSNumber) -> Bool {
    return left.compare(right) == ComparisonResult.orderedAscending
}

/**
 NSNumberの比較

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺より左辺が大きいもしくは同値かを判定
 */
public func >= (left : NSNumber, right : NSNumber) -> Bool {
    return left == right || left > right
}


/**
 NSNumberの比較

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺より左辺が小さいもしくは同値かを判定
 */
public func <= (left : NSNumber, right : NSNumber) -> Bool {
    return left == right || left < right
}

/**
 NSNumberの比較(等価)

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺と左辺が同値かを判定
 */
public func == (left : NSNumber, right : NSNumber) -> Bool {
    return left.isEqual(to: right)
}

/**
 NSNumberの比較(非等価)

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺と左辺が同値でないことを判定
 */
public func != (left : NSNumber, right : NSNumber) -> Bool {
    return !left.isEqual(to: right)
}

/**
 NSNumberの比較

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺より左辺が未来かを判定
 */
public func > (left : NSNumber?, right : NSNumber?) -> Bool {
    if let left = left , let right = right {
        return left > right
    }
    return false
}


/**
 NSNumberの比較

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺より左辺が過去かを判定
 */
public func < (left : NSNumber?, right : NSNumber?) -> Bool {
    if let left = left , let right = right {
        return left < right
    }
    return false
}

/**
 NSNumberの比較

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺より左辺が未来もしくは同時刻かを判定
 */
public func >= (left : NSNumber?, right : NSNumber?) -> Bool {
    if let left = left , let right = right {
        return left >= right
    }
    return false
}


/**
 NSNumberの比較

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺より左辺が過去もしくは同時刻かを判定
 */
public func <= (left : NSNumber?, right : NSNumber?) -> Bool {
    if let left = left , let right = right {
        return left <= right
    }
    return false
}

/**
 NSNumberの比較(等価)

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺と左辺が同値かを判定
 */
public func == (left : NSNumber?, right : NSNumber?) -> Bool {
    if let left = left , let right = right {
        return left == right
    }
    return false
}

/**
 NSNumberの比較(非等価)

 :param: left  NSNumber
 :param: right NSNumber

 :returns: 右辺と左辺が同値でないことを判定
 */
public func != (left : NSNumber?, right : NSNumber?) -> Bool {
    if let left = left , let right = right {
        return left != right
    }
    return false
}

extension NSNumber {
    /**
     桁数を取得

     :returns: 桁数
     */
    public func digits() -> Int {
        return Int(log10(self.doubleValue)) + 1
    }

}
