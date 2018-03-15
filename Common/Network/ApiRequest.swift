//
//  ApiRequest.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import Alamofire

public protocol ApiRequest {
    associatedtype Response

    var endpoint: String { get }
    var method: Alamofire.HTTPMethod { get }
    var encoding: URLEncoding { get }
    // Headerパラメータ
    var headerParameters: [String:String] { get }
    // QueryorBodyパラメータ
    var parameters: [String: Any]? { get }
    // タイムアウト
    var timeout: TimeInterval? { get }
}

extension ApiRequest {

    public var endpoint:String {
        return ""
    }

    public var headerParameters:[String: String] {
        return [:]
    }

    public var parameters: [String: Any]? {
        return [:]
    }

    public var timeout: TimeInterval? {
        return nil
    }
}
