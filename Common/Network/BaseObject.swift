//
//  BaseObject.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import ObjectMapper

public class BaseObject: NSObject {

    let strTransform = TransformOf<String, Any>(
        fromJSON: { (value: Any?) -> String? in
            guard let value = value else {
                return ""
            }
            if value is String {
                return value as? String
            } else if value is Int {
                if let intValue = value as? Int {
                    return String(intValue)
                } else {
                    return nil
                }
            }
            return ""
    }, toJSON: { (value: String?) -> Any? in
        // transform value from String? to Int?
        if let value = value {
            return value as Any?
        }
        return nil
    })

    var id = NSUUID().uuidString
    var createdAt = Date()
}
