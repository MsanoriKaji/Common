//
//  ApiClient.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import Alamofire
import enum Result.Result
import ObjectMapper

/// API通信基底クラス
class ApiClient {

    class Session {
        var alamofireRequest: Request? = nil
        init(_ request: Request) {
            alamofireRequest = request
        }
    }

    static var managers: [TimeInterval: SessionManager]
        = [ ApiClient.kTimeOutSecond: Alamofire.SessionManager(configuration: ApiClient.configuration)]

    static var manager: SessionManager {
        get {
            return managers[ApiClient.kTimeOutSecond]!
        }
    }

    // タイムアウト指定
    public static let kTimeOutSecond: TimeInterval = 30.0

    private static var configuration: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        config.timeoutIntervalForResource = ApiClient.kTimeOutSecond
        config.timeoutIntervalForRequest = ApiClient.kTimeOutSecond
        // キャッシュ情報を無視する
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        return config
    }

    private static var alamofireManager: Alamofire.SessionManager {
        return Alamofire.SessionManager(configuration: configuration)
    }

    // For static class.
    private init()  {
        // Intentionally unimplemented
    }

    /*!
     リクエストを送信

     - parameter request: リクエスト
     - parameter handler: ハンドラ

     - returns: リクエストから生成したセッション
     */
    public class func send<T: ApiRequest, U>
        (request: T, handler: ((Result<U, ApiClientError>) -> Void)? = nil ) -> Session
        where U: Mappable, U: ApiResponse {

            // APIにはトークンをヘッダーから渡す
            var headers: [String: String]? = nil

            // HeaderParameterが存在する場合、値を追加
            for (key, value) in request.headerParameters {
                if headers == nil {
                    headers = [key: value]
                } else {
                    headers![key] = value
                }
            }

            Log.d("RequestURL: \(request.endpoint)")

            // タイムアウト再設定
            var reqManager: SessionManager
            if let setTime = request.timeout {
                if let reserveManager = managers[setTime] {
                    reqManager = reserveManager
                } else {
                    reqManager = createManager(timeInterval: setTime)
                    managers[setTime] = reqManager
                }

            } else {
                reqManager = manager
            }

            let alamofireRequest =
                reqManager.request(request.endpoint,
                                   method: request.method,
                                   parameters: request.parameters,
                                   encoding: request.encoding,
                                   headers: headers)
                    .validate()
                    .response(completionHandler: {
                        (dataResponse: DefaultDataResponse) in

                        let response: Result<U, ApiClientError> =
                            ApiClient.mappingResponse(request: dataResponse.request,
                                                      response: dataResponse.response ,
                                                      data: dataResponse.data, error: dataResponse.error)
                        switch response {
                        case Result.success(let result):
                            handler?(Result<U, ApiClientError>.success(result))

                        case Result.failure(let error):
                            handler?(Result<U, ApiClientError>(error: error))
                        }
                    })

            return Session(alamofireRequest)
    }

    public class func createManager(timeInterval: TimeInterval?) -> SessionManager {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        config.timeoutIntervalForResource = timeInterval ?? ApiClient.kTimeOutSecond
        config.timeoutIntervalForRequest = timeInterval ?? ApiClient.kTimeOutSecond
        // キャッシュ情報を無視する
        config.requestCachePolicy = .reloadIgnoringLocalCacheData

        return Alamofire.SessionManager(configuration: config)
    }

    /**
     リクエスト送信処理をキャンセルします。
     対象の send() メソッドのハンドラにエラーレスポンスが返却されます。

     - parameter session:   セッション。send()メソッドの戻り値を使用します。
     */
    public class func cancel(session: Session) {
        session.alamofireRequest?.cancel()
    }

    public class func mappingResponse<T>
        (request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?)
        -> Result<T, ApiClientError> where T: Mappable, T: ApiResponse {

            Log.i("ResponseStatus: \(String(describing: response?.statusCode)), requestURL: \(String(describing: request?.url?.absoluteString))")

            if let error = error as NSError? {
                Log.d( "Alamofire Error:\(error)")
                if error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                    // 明示的なキャンセルの場合はCancelとする
                    return Result.failure(ApiClientError(type: .Canceled))
                } else {
                    // Alamofireのエラーの場合はNetworkError扱いとする
                    return Result.failure(ApiClientError(type: .NetworkError))
                }

            }

            // レスポンスが空の場合、固定のデータを入れる
            let validData: Data
            if let data = data , data.count > 0 {
                validData = data
            } else {
                validData = "{}".data(using: String.Encoding.utf8)!
            }

            Log.i("ResponseData:\(String(describing: String(data: validData, encoding: String.Encoding.utf8)))")

            guard let jsonDict =
                try? JSONSerialization.jsonObject(with: validData, options: .allowFragments) as? [String: Any] else {
                    return Result.failure(ApiClientError(type: .JsonParseError))
            }

            if let _ = (jsonDict?["results"] as? NSDictionary)?["error"] {
                return Result.failure(ApiClientError(type: .APIError))
            }

            guard let parsedObject: T = Mapper<T>().map(JSON: jsonDict!) else {
                return Result.failure(ApiClientError(type: .MappingError))
            }


            Log.i("parsedObject \(parsedObject)")

            //　正常終了
            return Result.success(parsedObject)

    }

    /**
     APIKeyを追加

     - parameter endpoint
     - return APIKeyを追加したendpoint
     */
    class func addApiKey(endpoint: String) -> String {
        // NOTE: 共通のURL加工等がある場合はここに記載
        return endpoint
    }
}
