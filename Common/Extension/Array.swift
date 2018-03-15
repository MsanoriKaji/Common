//
//  Array.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

extension Array {

    /*!
     データが存在する場合するかチェックする

     - returns: true存在 false存在しない
     */
    func isExist() -> Bool {
        return !self.isEmpty
    }

    /**
     Arrayのindexアクセスの安全対策
     例：
     var numbers = ["0", "1", "2"]

     -default
     numbers[0]  "0"
     numbers[3]  EXC_BAD_INSTRUCTION

     -this
     numbers[sefe: 0]  "0"
     numbers[safe: 3]  nil
     */
    subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}

extension Array where Element : Hashable {

    func distinct() -> [Element] {
        var distinctArray = [Element]()
        for element in self {
            if !distinctArray.contains(element) {
                distinctArray.append(element)
            }
        }
        return distinctArray
    }

    mutating func distinctInPrace() {
        self = self.distinct()
    }

}
