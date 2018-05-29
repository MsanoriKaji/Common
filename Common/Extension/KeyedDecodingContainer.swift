//
//  KeyedDecodingContainer.swift
//  Common
//
//  Created by ma_kaji on 2018/05/29.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {

    public func decode<T: Decodable> (forKey key: Key, defaultValue: T? = nil) -> T {
        do {
            return try decode(T.self, forKey: key)
        } catch  let error {
            logger.debug("Decode Error \(error.localizedDescription) set Default Value not ExistKey: \(key)")
            if let value = defaultValue {
                return  value
            }

            // swiftlint:disable force_cast
            if T.Type.self == String.Type.self {
                return "" as! T
            }

            if T.Type.self == Int.Type.self {
                return Int.defaultValue as! T
            }

            if T.Type.self == Double.Type.self {
                return Double(0) as! T
            }

            if T.Type.self == Float.Type.self {
                return Float(0) as! T
            }

            if T.Type.self == Bool.Type.self {
                return false as! T
            }

            if T.Type.self == Date.Type.self {
                return Date() as! T
            }
            // swiftlint:enable force_cast
            logger.error("Decode Not Define Error")
            return defaultValue!
        }
    }

    public func decode<T: Decodable> (forKey key: Key, defaultValue: T? = nil, nullable: Bool = false) -> T? {
        do {
            return try decode(T.self, forKey: key)
        } catch let error {
            logger.debug("Decode Error \(error.localizedDescription) set Default Value not ExistKey: \(key)")
            if defaultValue != nil {
                return  defaultValue
            }

            if nullable {
                return defaultValue
            } else {
                if T.Type.self == String.Type.self {
                    return "" as? T
                }

                if T.Type.self == Int.Type.self {
                    return Int.defaultValue as? T
                }

                if T.Type.self == Double.Type.self {
                    return Double(0) as? T
                }

                if T.Type.self == Float.Type.self {
                    return Float(0) as? T
                }

                if T.Type.self == Bool.Type.self {
                    return false as? T
                }
                // 他のデータ型の場合はnilを返却
                return nil
            }
        }
    }
}
