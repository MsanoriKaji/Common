//
//  ApiResponse.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import ObjectMapper

public class ApiResponse: Mappable {

    public var code: String = ""
    public var causes = [String]()

    public init() {
        // Intentionally unimplemented
    }

    public required init?(map: Map)  {
        // Intentionally unimplemented
    }

    public func mapping(map: Map) {
        // Intentionally unimplemented
    }
}

