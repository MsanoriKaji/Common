//
//  BaseNetworkModel.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

/// 通信系基底モデル
class BaseNetworkModel: NSObject {

    let kSingleSessionKey = "SingleSession"

    var baseInfos: [String: BaseResultEntity] = [:]
    var dataArrays: [String: [BaseObject]] = [:]
    var sessions: [String: ApiClient.Session?] = [:]

    var baseInfo: BaseResultEntity? {
        get {
            guard let baseInfo = baseInfos[kSingleSessionKey] else {
                return nil
            }
            return baseInfo
        }
        set(baseInfo) {
            baseInfos[kSingleSessionKey] = baseInfo
        }
    }

    var dataArray: [BaseObject] {
        get {
            guard let dataArray = dataArrays[kSingleSessionKey] else {
                return []
            }
            return dataArray
        }
        set(dataArray) {
            dataArrays[kSingleSessionKey] = dataArray
        }
    }

    var session: ApiClient.Session? {
        get {
            guard let session = sessions[kSingleSessionKey] else {
                return nil
            }
            return session
        }
        set(session) {
            if let session = session {
                sessions[kSingleSessionKey] = session
            } else {
                sessions.removeValue(forKey: kSingleSessionKey)
            }
        }
    }

    func itemAtIndex<T: BaseObject>(index: Int, key: String) -> T? {

        guard let dataArray = dataArrays[key], let item = dataArray[safe: index] as? T else {
            return nil
        }
        return item
    }


    func itemAtIndex<T: BaseObject>(index: Int) -> T? {
        guard let item = dataArray[safe: index] as? T else {
            return nil
        }
        return item
    }

    func numberOfItem(key: String) -> Int {
        guard let dataArray = dataArrays[key] else {
            return 0
        }
        return dataArray.count
    }


    func numberOfItem() -> Int {
        return dataArray.count
    }

    func cancelIfNeed() {
        sessions.filter({$0.1 != nil }).forEach {
            guard let request = $0.1?.alamofireRequest else {
                return
            }
            request.cancel()
        }
    }


    /*!
     データのクリアを行う
     */
    func clear() {
        baseInfos = [:]
        dataArrays = [:]
        sessions = [:]
    }

}
