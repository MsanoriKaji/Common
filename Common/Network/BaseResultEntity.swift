//
//  BaseResultEntity.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import ObjectMapper

///　共通結果
public class BaseResultEntity: BaseObject {

    public var apiVersion: String = ""
    public var resultAvailable: Int = 0
    public var resultsReturned: Int = 0
    public var resultsStart: String = ""

    convenience required public init?(map: Map) {
        self.init()
    }
}

extension BaseResultEntity: Mappable {

    /*!
     データマッピング

     - parameter map: レスポンスデータ
     */
    public func mapping(map: Map) {
        // NOTE: Mapping
        // apiVersion <- map["api_version"]
    }
}
